class SensorData {
  final int soil1;
  final int soil2;
  final int soil3;
  final int temp;
  final bool liquid;
  final bool relay1;
  final bool relay2;
  final bool relay3;

  SensorData({
    required this.soil1,
    required this.soil2,
    required this.soil3,
    required this.temp,
    required this.liquid,
    required this.relay1,
    required this.relay2,
    required this.relay3,
  });

  // Convert from Firebase JSON to SensorData object
  factory SensorData.fromJson(Map<dynamic, dynamic> json) {
    return SensorData(
      soil1: json['soil1'] ?? 0,
      soil2: json['soil2'] ?? 0,
      soil3: json['soil3'] ?? 0,
      temp: json['temp'] ?? 0,
      liquid: json['liquid'] ?? true,
      relay1: json['relay1'] ?? true,
      relay2: json['relay2'] ?? true,
      relay3: json['relay3'] ?? true,
    );
  }

  // Convert SensorData object to Firebase JSON
  Map<String, dynamic> toJson() {
    return {
      'soil1': soil1,
      'soil2': soil2,
      'soil3': soil3,
      'temp': temp,
      'liquid': liquid,
      'relay1': relay1,
      'relay2': relay2,
      'relay3': relay3,
    };
  }
}
