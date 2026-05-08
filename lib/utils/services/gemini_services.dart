import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ActuatorSuggestion {
  final int lampu;
  final int phdown;
  final int phup;
  final int pompa;
  final int durationSeconds;
  final String reason;

  ActuatorSuggestion({
    required this.lampu,
    required this.phdown,
    required this.phup,
    required this.pompa,
    required this.durationSeconds,
    required this.reason,
  });

  factory ActuatorSuggestion.fromJson(Map<String, dynamic> json) {
    return ActuatorSuggestion(
      lampu: json['lampu'] ?? 0,
      phdown: json['phdown'] ?? 0,
      phup: json['phup'] ?? 0,
      pompa: json['pompa'] ?? 0,
      durationSeconds: json['duration_seconds'] ?? 5,
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

ACTUATORS (intensity 0–100):
- pompa: irrigates soil (controls water pump)
- phdown: pumps pH-down solution into reservoir (lowers water pH)
- phup: pumps pH-up solution into reservoir (raises water pH)
Note: phdown and phup must never both be non-zero at the same time.

HARDWARE NOTE: At the end of duration_seconds, actuators fade down 20% every 0.5s automatically. Account for this fade-out in your duration estimate.

DECISION RULES — evaluate each independently, then combine:

1. IRRIGATION (pompa) — driven by soil humidity:
   - Target zone: 60–75%
   - 55–60%: intensity 15–25, duration 2–3s
   - 40–55%: intensity 30–55, duration 5–8s
   - 25–40%: intensity 60–80, duration 9–13s
   - <25%: intensity 85–100, duration 14–20s
   - ≥75%: OFF — soil is sufficiently moist
   - ≥80%: always OFF — waterlogging risk

2. pH ADJUSTMENT (phdown / phup) — driven by water reservoir pH:
   - Target zone: 5.8–6.2
   - pH 5.5–5.8 or 6.2–6.5: intensity 15–30, duration 2–3s
   - pH 5.0–5.5 or 6.5–7.0: intensity 35–60, duration 4–7s
   - pH <5.0 or >7.0: intensity 65–90, duration 8–13s
   - pH <5.8 → phup only; pH >6.2 → phdown only

3. EDGE CASES:
   - All sensors zero: all actuators OFF, duration 0, state dead sensors in reason
   - Any value ≥999 or negative: all actuators OFF, state sensor fault in reason
   - Multiple conditions: run both decisions independently; use the longer of the two durations

OUTPUT FORMAT (JSON only, no markdown):
{"phdown": 0-100, "phup": 0-100, "pompa": 0-100, "duration_seconds": 0-30, "reason": "one sentence max"}''';

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
