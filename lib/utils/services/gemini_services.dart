import 'dart:convert';
import 'package:dio/dio.dart';

class ActuatorSuggestion {
  final int lampu;
  final int phdown;
  final int phup;
  final int pompa;
  final String reason;

  ActuatorSuggestion({
    required this.lampu,
    required this.phdown,
    required this.phup,
    required this.pompa,
    required this.reason,
  });

  factory ActuatorSuggestion.fromJson(Map<String, dynamic> json) {
    return ActuatorSuggestion(
      lampu: json['lampu'] ?? 0,
      phdown: json['phdown'] ?? 0,
      phup: json['phup'] ?? 0,
      pompa: json['pompa'] ?? 0,
      reason: json['reason'] ?? 'No reason provided',
    );
  }
}

class GeminiService {
  // TODO: Replace with your actual Gemini API key from https://aistudio.google.com/app/apikey
  static const String apiKey = 'AIzaSyDYLwkEfcBlnqr26uiQ5sveB1rTku4vdLU';

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
    required int soilPH,
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
          '''Return ONLY this JSON format with suggested actuator values (0-100):
{"lampu": 50, "phdown": 0, "phup": 0, "pompa": 30, "reason": "explanation"}

Sensor data: Soil pH=$soilPH, Humidity=$soilHumidity%, Temp=$soilTemp°C
Rules: pH 6-7 is optimal. If pH<6 increase phup. If pH>7 increase phdown. If humidity<40% increase pompa.''';

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
