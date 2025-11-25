import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';

class ActuatorControlDialog extends StatelessWidget {
  const ActuatorControlDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E7D32),
              Color(0xFF388E3C),
              Color(0xFF43A047),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings_remote, color: Colors.white, size: 28),
                const SizedBox(width: 10),
                const Text(
                  'Control Panel',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildControlCard(
                      icon: Icons.lightbulb,
                      label: 'Lamp',
                      color: const Color(0xFFFFEB3B),
                      controller: IotController.to,
                      getValue: () => IotController.to.lampState,
                      onChanged: (value) =>
                          IotController.to.setLampValue(value.toInt()),
                    ),
                    const SizedBox(height: 16),
                    _buildControlCard(
                      icon: Icons.water_drop,
                      label: 'pH Down',
                      color: const Color(0xFFFF5722),
                      controller: IotController.to,
                      getValue: () => IotController.to.phDownState,
                      onChanged: (value) =>
                          IotController.to.setPhDownValue(value.toInt()),
                    ),
                    const SizedBox(height: 16),
                    _buildControlCard(
                      icon: Icons.water_drop_outlined,
                      label: 'pH Up',
                      color: const Color(0xFF2196F3),
                      controller: IotController.to,
                      getValue: () => IotController.to.phUpState,
                      onChanged: (value) =>
                          IotController.to.setPhUpValue(value.toInt()),
                    ),
                    const SizedBox(height: 16),
                    _buildControlCard(
                      icon: Icons.opacity,
                      label: 'Pump',
                      color: const Color(0xFF00BCD4),
                      controller: IotController.to,
                      getValue: () => IotController.to.pumpState,
                      onChanged: (value) =>
                          IotController.to.setPumpValue(value.toInt()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2E7D32),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Close',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCard({
    required IconData icon,
    required String label,
    required Color color,
    required IotController controller,
    required int Function() getValue,
    required Function(double) onChanged,
  }) {
    return Obx(() {
      final value = getValue();
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.8), color],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '$value%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderThemeData(
                activeTrackColor: color,
                inactiveTrackColor: color.withOpacity(0.3),
                thumbColor: color,
                overlayColor: color.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              ),
              child: Slider(
                value: value.toDouble(),
                min: 0,
                max: 100,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
    });
  }
}
