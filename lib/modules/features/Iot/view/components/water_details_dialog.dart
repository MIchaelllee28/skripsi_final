import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class WaterDetailsDialog extends StatelessWidget {
  const WaterDetailsDialog({super.key});

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
                  colors: [Colors.blue.shade500, Colors.blue.shade800],
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
                  const Icon(Icons.water_rounded,
                      color: Colors.white, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'WATER MONITOR',
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
                          icon: Icons.bolt_rounded,
                          label: 'TDS',
                          value: '${IotController.to.waterTDS} ppm',
                          rawValue: IotController.to.waterTDS.toDouble(),
                          unit: 'ppm',
                          min: 0,
                          max: 2500,
                          optimalMin: 800,
                          optimalMax: 1500,
                          rangeLabel: 'Optimal: 800 – 1500 ppm',
                          color: Colors.cyan.shade400,
                          accentColor: Colors.cyan.shade700,
                          statusLogic: _tdsStatus,
                        ),
                        const SizedBox(height: 12),
                        _buildSensorCard(
                          icon: Icons.science_rounded,
                          label: 'Water pH',
                          value: IotController.to.waterPH.toStringAsFixed(2),
                          rawValue: IotController.to.waterPH,
                          unit: 'pH',
                          min: 0,
                          max: 14,
                          optimalMin: 5.8,
                          optimalMax: 6.2,
                          rangeLabel: 'Optimal: 5.8 – 6.2',
                          color: Colors.blue.shade400,
                          accentColor: Colors.blue.shade700,
                          statusLogic: _waterPhStatus,
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

  _StatusInfo _tdsStatus(double v) {
    if (v <= 0) return _StatusInfo('NO SIGNAL', Colors.grey);
    if (v < 500) return _StatusInfo('VERY LOW', Colors.red.shade700);
    if (v < 800) return _StatusInfo('LOW', Colors.orange.shade700);
    if (v <= 1500) return _StatusInfo('OPTIMAL', Colors.green.shade600);
    if (v <= 2000) return _StatusInfo('HIGH', Colors.orange.shade700);
    return _StatusInfo('CRITICAL HIGH', Colors.red.shade700);
  }

  _StatusInfo _waterPhStatus(double v) {
    if (v <= 0) return _StatusInfo('NO SIGNAL', Colors.grey);
    if (v < 5.0) return _StatusInfo('CRITICAL LOW', Colors.red.shade700);
    if (v < 5.8) return _StatusInfo('LOW', Colors.orange.shade700);
    if (v <= 6.2) return _StatusInfo('OPTIMAL', Colors.green.shade600);
    if (v <= 7.0) return _StatusInfo('HIGH', Colors.orange.shade700);
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
                  // Optimal zone highlight
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: optFraction + optWidth,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: optWidth / (optFraction + optWidth),
                      child: Container(color: Colors.green.shade100),
                    ),
                  ),
                  // Current value fill
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

          // Range labels
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
                '0 – ${max.toInt()} $unit',
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
