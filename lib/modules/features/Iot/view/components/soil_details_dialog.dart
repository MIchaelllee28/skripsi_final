import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class SoilDetailsDialog extends StatelessWidget {
  const SoilDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5DC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF8B4513), width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.brown.shade400, Colors.brown.shade600],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: const Border(
                  bottom: BorderSide(color: Color(0xFF8B4513), width: 3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.landscape_rounded,
                      color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'SOIL MONITOR',
                      style: GoogleTextStyle.fw700.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            // Cards
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Obx(() => Column(
                      children: [
                        _buildSensorCard(
                          icon: Icons.water_drop_rounded,
                          label: 'Soil Humidity',
                          value:
                              '${IotController.to.soilHumidity.toStringAsFixed(1)}%',
                          rawValue: IotController.to.soilHumidity,
                          unit: '%',
                          min: 0,
                          max: 100,
                          optimalMin: 60,
                          optimalMax: 75,
                          rangeLabel: 'Optimal: 60 – 75%',
                          color: Colors.blue.shade400,
                          accentColor: Colors.blue.shade700,
                          statusLogic: _humidityStatus,
                        ),
                        const SizedBox(height: 12),
                        _buildSensorCard(
                          icon: Icons.science_rounded,
                          label: 'Soil pH',
                          value: IotController.to.soilPH.toStringAsFixed(2),
                          rawValue: IotController.to.soilPH,
                          unit: 'pH',
                          min: 0,
                          max: 14,
                          optimalMin: 6.0,
                          optimalMax: 7.0,
                          rangeLabel: 'Optimal: 6.0 – 7.0',
                          color: Colors.green.shade400,
                          accentColor: Colors.green.shade700,
                          statusLogic: _soilPhStatus,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusInfo _humidityStatus(double v) {
    if (v <= 0) return _StatusInfo('NO SIGNAL', Colors.grey);
    if (v < 25) return _StatusInfo('CRITICAL LOW', Colors.red.shade700);
    if (v < 40) return _StatusInfo('LOW', Colors.orange.shade700);
    if (v < 60) return _StatusInfo('BELOW OPTIMAL', Colors.amber.shade700);
    if (v <= 75) return _StatusInfo('OPTIMAL', Colors.green.shade600);
    if (v <= 80) return _StatusInfo('ABOVE OPTIMAL', Colors.orange.shade600);
    return _StatusInfo('WATERLOGGING RISK', Colors.red.shade700);
  }

  _StatusInfo _soilPhStatus(double v) {
    if (v <= 0) return _StatusInfo('NO SIGNAL', Colors.grey);
    if (v < 5.5) return _StatusInfo('CRITICAL LOW', Colors.red.shade700);
    if (v < 6.0) return _StatusInfo('LOW', Colors.orange.shade700);
    if (v <= 7.0) return _StatusInfo('OPTIMAL', Colors.green.shade600);
    if (v <= 7.5) return _StatusInfo('HIGH', Colors.orange.shade700);
    return _StatusInfo('CRITICAL HIGH', Colors.red.shade700);
  }

  Widget _buildSensorCard({
    required IconData icon,
    required String label,
    required String value,
    required double rawValue,
    required String unit,
    required double min,
    required double max,
    required double optimalMin,
    required double optimalMax,
    required String rangeLabel,
    required Color color,
    required Color accentColor,
    required _StatusInfo Function(double) statusLogic,
  }) {
    final status = statusLogic(rawValue);
    final fraction = ((rawValue - min) / (max - min)).clamp(0.0, 1.0);
    final optFraction = (optimalMin - min) / (max - min);
    final optWidth = (optimalMax - optimalMin) / (max - min);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF8B4513), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: icon + label + value
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: GoogleTextStyle.fw700.copyWith(
                    fontSize: 16,
                    color: const Color(0xFF2C3E50),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [color, accentColor]),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentColor, width: 2),
                ),
                child: Text(
                  value,
                  style: GoogleTextStyle.fw700.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: status.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: status.color, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  status.label == 'OPTIMAL'
                      ? Icons.check_circle_rounded
                      : Icons.warning_amber_rounded,
                  color: status.color,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  status.label,
                  style: GoogleTextStyle.fw700.copyWith(
                    fontSize: 12,
                    color: status.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Range bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 18,
              child: Stack(
                children: [
                  // Background
                  Container(color: Colors.grey.shade200),
                  // Optimal zone
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: optFraction + optWidth,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: optWidth / (optFraction + optWidth),
                      child: Container(
                        color: Colors.green.shade100,
                      ),
                    ),
                  ),
                  // Current value marker
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: fraction.clamp(0.02, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [color, accentColor]),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                    ),
                  ),
                  // Border overlay
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Range label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rangeLabel,
                style: GoogleTextStyle.fw600.copyWith(
                  fontSize: 11,
                  color: Colors.green.shade700,
                ),
              ),
              Text(
                '${min.toInt()} – ${max.toInt()} $unit',
                style: GoogleTextStyle.fw400.copyWith(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusInfo {
  final String label;
  final Color color;
  const _StatusInfo(this.label, this.color);
}
