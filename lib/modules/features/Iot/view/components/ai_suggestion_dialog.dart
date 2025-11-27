import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class AISuggestionDialog extends StatelessWidget {
  const AISuggestionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = IotController.to;
    final suggestion = controller.aiSuggestion.value;

    if (suggestion == null) return const SizedBox();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade400,
                    Colors.purple.shade600,
                  ],
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
                  const Icon(Icons.psychology, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'AI SUGGESTIONS',
                      style: GoogleTextStyle.fw700.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Gemini Pro',
                      style: GoogleTextStyle.fw600.copyWith(
                        fontSize: 12,
                        color: Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reason box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.blue.shade300, width: 2),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.blue.shade700, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              suggestion.reason,
                              style: GoogleTextStyle.fw500.copyWith(
                                fontSize: 14,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Suggested Values:',
                      style: GoogleTextStyle.fw700.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF2C3E50),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Suggested values
                    _buildValueRow('💡 Lamp', suggestion.lampu, Colors.amber),
                    _buildValueRow('🔻 pH Down', suggestion.phdown, Colors.red),
                    _buildValueRow('🔺 pH Up', suggestion.phup, Colors.teal),
                    _buildValueRow('💧 Pump', suggestion.pompa, Colors.blue),
                  ],
                ),
              ),
            ),

            // Buttons
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF8B4513), width: 3),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildButton(
                      label: 'REJECT',
                      icon: Icons.close,
                      color: Colors.red,
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildButton(
                      label: 'APPLY',
                      icon: Icons.check,
                      color: Colors.green,
                      onTap: () => controller.applyAISuggestion(suggestion),
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

  Widget _buildValueRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleTextStyle.fw600.copyWith(
                fontSize: 14,
                color: const Color(0xFF2C3E50),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color, width: 2),
            ),
            child: Text(
              '$value%',
              style: GoogleTextStyle.fw700.copyWith(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF8B4513), width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(3, 3),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleTextStyle.fw700.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
