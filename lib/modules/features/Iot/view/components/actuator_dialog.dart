import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:trainee/modules/features/Iot/view/components/ai_suggestion_dialog.dart';

class ActuatorControlDialog extends StatelessWidget {
  const ActuatorControlDialog({super.key});

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
            // Pixel-style header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MainColor.primary.withOpacity(0.9),
                    MainColor.info,
                  ],
                ),
                border: const Border(
                  bottom: BorderSide(color: Color(0xFF8B4513), width: 3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.videogame_asset_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'ACTUATOR PANEL',
                      style: GoogleTextStyle.fw700.copyWith(
                        fontSize: 22,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            color: Colors.black45,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Reset button
                  GestureDetector(
                    onTap: () => IotController.to.resetAllActuators(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.orange.shade200, width: 2),
                      ),
                      child: const Icon(
                        Icons.restart_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildPixelControlCard(
                      icon: Icons.lightbulb_rounded,
                      label: 'LAMP',
                      color: const Color(0xFFFFD700),
                      accentColor: const Color(0xFFFFA500),
                      controller: IotController.to,
                      getValue: () => IotController.to.lampState,
                      onChanged: (value) =>
                          IotController.to.setLampValue(value.toInt()),
                    ),
                    const SizedBox(height: 12),
                    _buildPixelControlCard(
                      icon: Icons.water_drop_rounded,
                      label: 'pH DOWN',
                      color: const Color(0xFFFF6B6B),
                      accentColor: const Color(0xFFEE5A6F),
                      controller: IotController.to,
                      getValue: () => IotController.to.phDownState,
                      onChanged: (value) =>
                          IotController.to.setPhDownValue(value.toInt()),
                    ),
                    const SizedBox(height: 12),
                    _buildPixelControlCard(
                      icon: Icons.water_drop_outlined,
                      label: 'pH UP',
                      color: const Color(0xFF4ECDC4),
                      accentColor: const Color(0xFF44A3A0),
                      controller: IotController.to,
                      getValue: () => IotController.to.phUpState,
                      onChanged: (value) =>
                          IotController.to.setPhUpValue(value.toInt()),
                    ),
                    const SizedBox(height: 12),
                    _buildPixelControlCard(
                      icon: Icons.water_rounded,
                      label: 'PUMP',
                      color: const Color(0xFF95E1D3),
                      accentColor: const Color(0xFF38ADA9),
                      controller: IotController.to,
                      getValue: () => IotController.to.pumpState,
                      onChanged: (value) =>
                          IotController.to.setPumpValue(value.toInt()),
                    ),
                  ],
                ),
              ),
            ),
            // Pixel-style footer with AI and close buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF8B4513), width: 3),
                ),
              ),
              child: Row(
                children: [
                  // AI Suggest Button
                  Expanded(
                    child: Obx(() => GestureDetector(
                          onTap: IotController.to.isLoadingAI.value
                              ? null
                              : () {
                                  Get.back(); // Close actuator dialog
                                  IotController.to.getAISuggestions();
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: IotController.to.isLoadingAI.value
                                    ? [
                                        Colors.grey.shade400,
                                        Colors.grey.shade600
                                      ]
                                    : [
                                        Colors.purple.shade400,
                                        Colors.purple.shade600
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: const Color(0xFF8B4513), width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: const Offset(4, 4),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (IotController.to.isLoadingAI.value)
                                  const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                else
                                  const Icon(Icons.psychology,
                                      color: Colors.white, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  IotController.to.isLoadingAI.value
                                      ? 'THINKING...'
                                      : 'AI SUGGEST',
                                  style: GoogleTextStyle.fw700.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                    shadows: [
                                      const Shadow(
                                        color: Colors.black45,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(width: 12),
                  // Close Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE74C3C),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color(0xFF8B4513), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(4, 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.close_rounded,
                                color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'CLOSE',
                              style: GoogleTextStyle.fw700.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                                shadows: [
                                  const Shadow(
                                    color: Colors.black45,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPixelControlCard({
    required IconData icon,
    required String label,
    required Color color,
    required Color accentColor,
    required IotController controller,
    required int Function() getValue,
    required Function(double) onChanged,
    int maxValue = 100,
    String unit = '%',
  }) {
    return Obx(() {
      final value = getValue();
      final isActive = value > 0;

      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? accentColor : const Color(0xFF8B4513),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? accentColor.withOpacity(0.4)
                  : Colors.black.withOpacity(0.3),
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Pixel icon badge
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isActive
                          ? [color, accentColor]
                          : [
                              color.withOpacity(0.3),
                              accentColor.withOpacity(0.3),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isActive ? accentColor : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: isActive ? Colors.white : Colors.grey.shade600,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                // Label
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleTextStyle.fw700.copyWith(
                          fontSize: 18,
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: isActive
                              ? color.withOpacity(0.2)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isActive ? '● ACTIVE' : '○ OFF',
                          style: GoogleTextStyle.fw600.copyWith(
                            fontSize: 11,
                            color:
                                isActive ? accentColor : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Pixel value display
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, accentColor],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    '$value$unit',
                    style: GoogleTextStyle.fw700.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Pixel-style progress bar
            Stack(
              children: [
                // Background track
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade500, width: 2),
                  ),
                ),
                // Progress fill
                FractionallySizedBox(
                  widthFactor: maxValue > 0 ? value / maxValue : 0,
                  child: Container(
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, accentColor],
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: accentColor, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Slider
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 8,
                activeTrackColor: accentColor,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: Colors.white,
                overlayColor: color.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 12,
                  elevation: 2,
                ),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                trackShape: const RoundedRectSliderTrackShape(),
              ),
              child: Slider(
                value: value.toDouble(),
                min: 0,
                max: maxValue.toDouble(),
                divisions: maxValue ~/ 10,
                label: '$value$unit',
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
    });
  }
}
