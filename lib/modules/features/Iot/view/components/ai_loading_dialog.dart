import 'package:flutter/material.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class AILoadingDialog extends StatelessWidget {
  const AILoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
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
            // Animated brain icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade400,
                    Colors.purple.shade600,
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 48,
              ),
            ),

            const SizedBox(height: 24),

            // Loading indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.purple.shade600,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Text
            Text(
              'AI is thinking...',
              style: GoogleTextStyle.fw700.copyWith(
                fontSize: 20,
                color: const Color(0xFF2C3E50),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Analyzing sensor data',
              style: GoogleTextStyle.fw500.copyWith(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 16),

            // Gemini badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.purple.shade300, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 16,
                    color: Colors.purple.shade700,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Powered by Gemini',
                    style: GoogleTextStyle.fw600.copyWith(
                      fontSize: 12,
                      color: Colors.purple.shade700,
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
}
