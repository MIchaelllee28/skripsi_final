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
      hum: double.tryParse(json['hum']?.toString() ?? '0') ?? 0.0,
      temp: double.tryParse(json['temp']?.toString() ?? '0') ?? 0.0,
      ec: int.tryParse(json['ec']?.toString() ?? '0') ?? 0,
      ph: double.tryParse(json['ph']?.toString() ?? '0') ?? 0.0,
      n: int.tryParse(json['n']?.toString() ?? '0') ?? 0,
      p: int.tryParse(json['p']?.toString() ?? '0') ?? 0,
      k: int.tryParse(json['k']?.toString() ?? '0') ?? 0,
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
      cf: int.tryParse(json['cf']?.toString() ?? '0') ?? 0,
      ph: double.tryParse(json['ph']?.toString() ?? '0') ?? 0.0,
      humid: int.tryParse(json['humid']?.toString() ?? '0') ?? 0,
      suhu: double.tryParse(json['suhu']?.toString() ?? '0') ?? 0.0,
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
