import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ActuatorSuggestion {
  final int lampu;
  final int phdown;
  final int phup;
  final int pompa;
  final int durationSeconds;
  final int pompaDurationSeconds;
  final String reason;

  ActuatorSuggestion({
    required this.lampu,
    required this.phdown,
    required this.phup,
    required this.pompa,
    required this.durationSeconds,
    required this.pompaDurationSeconds,
    required this.reason,
  });

  bool get isSequential =>
      (phdown > 0 || phup > 0) && pompa > 0 && pompaDurationSeconds > 0;

  factory ActuatorSuggestion.fromJson(Map<String, dynamic> json) {
    return ActuatorSuggestion(
      lampu: json['lampu'] ?? 0,
      phdown: (json['phdown'] ?? 0) > 0 ? 40 : 0, // fixed at 40% when active
      phup: (json['phup'] ?? 0) > 0 ? 40 : 0,     // fixed at 40% when active
      pompa: 40, // fixed at 40% — pump speed is hardware-controlled
      durationSeconds: json['duration_seconds'] ?? 5,
      pompaDurationSeconds: json['pompa_duration_seconds'] ?? 0,
      reason: json['reason'] ?? 'No reason provided',
    );
  }
}

class GeminiService {
  // Read from .env file
  static String get apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  // Test method to check API key and list models
  static Future<void> testApiKey() async {
    try {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://generativelanguage.googleapis.com',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      final response = await dio.get('/v1beta/models?key=$apiKey');
      print('✅ API Key works!');
      print('Available models: ${response.data}');
    } catch (e) {
      print('❌ API Key test failed: $e');
    }
  }

  static Future<ActuatorSuggestion?> getActuatorSuggestions({
    required double soilHumidity,
    required double soilPH,
    required int waterTDS,
    required double waterPH,
  }) async {
    try {
      final prompt =
          '''You are an automation controller for a hydroponic plant system. Given sensor readings, decide which actuators to run.

SENSOR READINGS:
Soil:
- Humidity: $soilHumidity% (optimal: 60-75%)
- pH: $soilPH (optimal: 6.0-7.0)

Water Reservoir:
- TDS: $waterTDS ppm (optimal: 800-1500)
- pH: $waterPH (optimal: 5.8-6.2)

ACTUATORS (all speeds are FIXED by hardware — only decide ON/OFF and duration):
- pompa: water pump — FIXED at 40% speed (flow rate = 3.79 ml/s). Do NOT output pompa intensity.
- phdown: pH-down pump — FIXED at 40% speed (flow rate = 3.79 ml/s). Output 40 if ON, 0 if OFF.
- phup: pH-up pump — FIXED at 40% speed (flow rate = 3.79 ml/s). Output 40 if ON, 0 if OFF.
- Reservoir = 10L. Tube fill time = 5s (liquid only reaches reservoir after 5s of pumping).
Note: phdown and phup must never both be non-zero at the same time.

HARDWARE NOTE: At the end of duration_seconds, actuators fade down 20% every 0.5s automatically. Account for this fade-out in your duration estimate.

DECISION RULES:

1. IRRIGATION (pompa) — driven by soil humidity. Pump runs at 40% = 3.79 ml/s:
   - Target zone: 60–75%
   - 55–60%: pompa_duration_seconds 8–12s (~30–45 ml)
   - 40–55%: pompa_duration_seconds 21–33s (~80–125 ml)
   - 25–40%: pompa_duration_seconds 37–53s (~140–201 ml)
   - <25%: pompa_duration_seconds 57–82s (~216–311 ml)
   - ≥75%: pompa OFF → pompa_duration_seconds=0

2. pH ADJUSTMENT (phdown / phup) — driven by water reservoir pH. Pump at 40% = 3.79 ml/s, reservoir = 10L:
   - Target zone: 5.8–6.2
   - deviation 0–0.5: duration_seconds 2–3s (~7.6–11.4 ml)
   - deviation 0.5–1.5: duration_seconds 3–5s (~11.4–19 ml)
   - deviation >1.5: duration_seconds 5–7s (~19–26.5 ml)
   - pH <5.8 → phup=40, phdown=0; pH >6.2 → phdown=40, phup=0
   - No pH issue → phdown=0, phup=0, duration_seconds=0

3. TWO-STEP SEQUENCING: If BOTH pH and irrigation are needed, the app runs them sequentially:
   - Step 1: pH pump runs for duration_seconds
   - Step 2: water pump runs for pompa_duration_seconds
   - Set BOTH fields independently. Do NOT merge them into one duration.

4. EDGE CASES:
   - All sensors zero OR any<0 OR any≥999 → all OFF, duration_seconds=0, pompa_duration_seconds=0

OUTPUT FORMAT (JSON only, no markdown):
{"phdown": 0-100, "phup": 0-100, "duration_seconds": 0-30, "pompa_duration_seconds": 0-120, "reason": "one sentence max"}''';

      // Create Dio instance for Gemini API
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://generativelanguage.googleapis.com',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // Successfully updated to a valid model: gemini-2.5-flash
      final response = await dio.post(
        '/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey',
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 2000,
            'responseModalities': ['TEXT'],
          },
          'systemInstruction': {
            'parts': [
              {
                'text':
                    'You must respond with ONLY valid JSON. No thinking, no explanation, just JSON.'
              }
            ]
          }
        },
      );

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        print('Full response: $data');

        // Extract text from Gemini response
        final candidates = data['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final candidate = candidates[0];
          print('Candidate: $candidate');

          // Check if content exists and has parts
          final content = candidate['content'];
          if (content != null) {
            final parts = content['parts'] as List?;
            if (parts != null && parts.isNotEmpty) {
              final text = parts[0]['text'] as String;
              print('Gemini Response Text: $text');

              // Clean response
              String cleanedText =
                  text.replaceAll('```json', '').replaceAll('```', '').trim();

              // Extract JSON - more flexible regex
              final jsonMatch = RegExp(r'\{[\s\S]*?\}').firstMatch(cleanedText);
              if (jsonMatch != null) {
                final jsonStr = jsonMatch.group(0)!;
                print('Extracted JSON: $jsonStr');
                final jsonData = jsonDecode(jsonStr);
                return ActuatorSuggestion.fromJson(jsonData);
              } else {
                print('No JSON found in response');
              }
            } else {
              print('No parts in content');
            }
          } else {
            print('No content in candidate');
          }
        } else {
          print('No candidates in response');
        }
      }

      print('Failed to parse response');
      return null;
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      if (e.response != null) {
        print('Response: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
