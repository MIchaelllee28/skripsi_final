class SensorData {
  final SensorT sensorT;
  final SensorA sensorA;

  SensorData({
    required this.sensorT,
    required this.sensorA,
  });

  factory SensorData.fromJson(Map<dynamic, dynamic> json) {
    return SensorData(
      sensorT: SensorT.fromJson(json['sensorT'] ?? {}),
      sensorA: SensorA.fromJson(json['sensorA'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensorT': sensorT.toJson(),
      'sensorA': sensorA.toJson(),
    };
  }
}

// Soil/Tanah Sensor Data
class SensorT {
  final double hum; // humidity
  final double temp; // temperature
  final int ec; // electrical conductivity
  final double ph; // acidity
  final int n; // nitrogen
  final int p; // phosphorus
  final int k; // potassium

  SensorT({
    required this.hum,
    required this.temp,
    required this.ec,
    required this.ph,
    required this.n,
    required this.p,
    required this.k,
  });

  factory SensorT.fromJson(Map<dynamic, dynamic> json) {
    return SensorT(
      hum: (json['hum'] is num ? (json['hum'] as num).toDouble() : 0.0),
      temp: (json['temp'] is num ? (json['temp'] as num).toDouble() : 0.0),
      ec: (json['ec'] is num ? (json['ec'] as num).toInt() : 0),
      ph: (json['ph'] is num ? (json['ph'] as num).toDouble() : 0.0),
      n: (json['n'] is num ? (json['n'] as num).toInt() : 0),
      p: (json['p'] is num ? (json['p'] as num).toInt() : 0),
      k: (json['k'] is num ? (json['k'] as num).toInt() : 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hum': hum,
      'temp': temp,
      'ec': ec,
      'ph': ph,
      'n': n,
      'p': p,
      'k': k,
    };
  }
}

// Air/Water Sensor Data
class SensorA {
  final int cf; // CO2 concentration
  final double ph; // pH
  final int humid; // humidity
  final double suhu; // temperature

  SensorA({
    required this.cf,
    required this.ph,
    required this.humid,
    required this.suhu,
  });

  factory SensorA.fromJson(Map<dynamic, dynamic> json) {
    return SensorA(
      cf: (json['cf'] is num ? (json['cf'] as num).toInt() : 0),
      ph: (json['ph'] is num ? (json['ph'] as num).toDouble() : 0.0),
      humid: (json['humid'] is num ? (json['humid'] as num).toInt() : 0),
      suhu: (json['suhu'] is num ? (json['suhu'] as num).toDouble() : 0.0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cf': cf,
      'ph': ph,
      'humid': humid,
      'suhu': suhu,
    };
  }
}
