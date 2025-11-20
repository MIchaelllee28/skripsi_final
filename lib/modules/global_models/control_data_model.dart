class ControlData {
  final int lampu; // lamp control
  final int phdown; // pH down pump
  final int phup; // pH up pump
  final int pompa; // main pump

  ControlData({
    required this.lampu,
    required this.phdown,
    required this.phup,
    required this.pompa,
  });

  factory ControlData.fromJson(Map<dynamic, dynamic> json) {
    return ControlData(
      lampu: json['lampu'] ?? 0,
      phdown: json['phdown'] ?? 0,
      phup: json['phup'] ?? 0,
      pompa: json['pompa'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lampu': lampu,
      'phdown': phdown,
      'phup': phup,
      'pompa': pompa,
    };
  }
}
