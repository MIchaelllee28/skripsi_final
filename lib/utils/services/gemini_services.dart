import 'dart:convert';
import 'package:dio/dio.dart';

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
  // TODO: Replace with your actual Gemini API key from https://aistudio.google.com/app/apikey
  static const String apiKey = 'AIzaSyDSuQaj8xVGWQ1kWXaURMG1NT1n1Wp-FZc';

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
    required double soilTemp,
    required double soilPH,
    required int soilEC,
    required int soilN,
    required int soilP,
    required int soilK,
    required int airCO2,
    required int airHumidity,
    required double airTemp,
    required double airPH,
  }) async {
    try {
      final prompt =
          '''You are an expert agricultural automation system. Analyze the sensor data and provide optimal actuator settings.

CURRENT SENSOR READINGS:
Soil Conditions:
- Humidity: $soilHumidity% (optimal: 40-60%)
- Temperature: $soilTemp°C (optimal: 20-25°C)
- pH Level: $soilPH (optimal: 6.0-7.0)
- EC (Electrical Conductivity): $soilEC µS/cm (optimal: 1000-2000)
- NPK Levels: N=$soilN, P=$soilP, K=$soilK mg/kg

Air/Environment:
- CO2: $airCO2 ppm (optimal: 400-1000)
- Humidity: $airHumidity% (optimal: 50-70%)
- Temperature: $airTemp°C
- Water pH: $airPH

AVAILABLE ACTUATORS (0-100 scale):
- lampu: Grow light intensity (0=off, 100=max)
- phdown: pH down solution pump (lowers pH)
- phup: pH up solution pump (raises pH)
- pompa: Water pump for irrigation

INSTRUCTIONS:
1. Analyze if current conditions are optimal
2. Suggest gradual adjustments (avoid extreme changes)
3. Consider plant health and safety
4. If conditions are good, suggest minimal or no changes
5. Provide a very short, compact reason (max 1 sentence) for your actions.
6. Specify duration_seconds (1-30) for how long these settings should run before turning off. If no action needed, duration_seconds is 0.
7. HARDWARE SAFETY NOTE: To prevent inductive kickback, the actuators will automatically fade down by 20% every 0.5s at the end of your duration_seconds until they hit 0. Please consider this extra fade-out volume delivery in your time calculations.

BEHAVIORAL REFERENCES (Use these as examples to scale your response dynamically):
- As conditions approach Ideal (Hum ~70%, pH ~6.2), gracefully scale down actuators towards OFF (0s).
- For slight deviations (e.g. Hum ~55%, or pH ~5.0 / 7.0), use low intensity (e.g. 20-40) and short durations (3-4s).
- For moderate deviations (e.g. Hum ~40%, or pH ~4.8 / 7.5), use medium intensity (e.g. 40-70) and moderate durations (6-8s).
- For extreme deviations (e.g. Hum <=25%, or pH <=3.5 / >=8.5), use high intensity (e.g. 80-100) and long durations (10-15s).
- If multiple boundaries are crossed (e.g. Dry & Acidic), activate both Pump and the appropriate pH adjustment pump together.
- Safety / Out of bounds: If you detect impossible values (Overflow like 999, negative Underflow, or completely dead sensors at 0), employ extreme fail-safes (e.g. fully OFF if dead sensors, or max corrections for overflow) and state it in the reason.
- Waterlogging check: If humidity is extremely high (e.g. >=80%), hold the water pump OFF regardless of other variables.

OUTPUT FORMAT (JSON only, no markdown):
{"lampu": 0-100, "phdown": 0-100, "phup": 0-100, "pompa": 0-100, "duration_seconds": 1-30, "reason": "very short explanation (max 1 sentence)"}''';

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

      // Use the correct model name from available models
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
