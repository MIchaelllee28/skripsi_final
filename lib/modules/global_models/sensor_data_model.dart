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

// Water Sensor Data
class SensorA {
  final int tds; // TDS (reads 'adc' key in Firebase)
  final double ph; // pH

  SensorA({
    required this.tds,
    required this.ph,
  });

  factory SensorA.fromJson(Map<dynamic, dynamic> json) {
    return SensorA(
      tds: int.tryParse(json['tds']?.toString() ?? '0') ?? 0,
      ph: double.tryParse(json['ph']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tds': tds,
      'ph': ph,
    };
  }
}
