import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/modules/features/lucky_wheel/controllers/lucky_wheel_controller.dart';

class LuckyWheelView extends StatelessWidget {
  const LuckyWheelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LuckyWheelController());

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF66BB6A),
        elevation: 0,
        title: Text(
          '🎡 Daily Lucky Spin',
          style: GoogleFonts.pressStart2p(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF66BB6A),
              const Color(0xFFE8F5E9),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Title decoration
                _buildPixelBorder(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'SPIN FOR REWARDS!',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 12,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Wheel with pixel frame
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer pixel frame
                    _buildPixelFrame(320),

                    // Wheel
                    Obx(() => AnimatedRotation(
                          turns: controller.rotation.value / 360,
                          duration: const Duration(seconds: 4),
                          curve: Curves.easeOutCubic,
                          child: _buildWheel(controller),
                        )),

                    // Pointer at top
                    Positioned(
                      top: -5,
                      child: _buildPixelPointer(),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Spin Button with animation
                Obx(() {
                  final canSpin = controller.canSpin();
                  return _buildLeverButton(
                    controller: controller,
                    canSpin: canSpin,
                  );
                }),

                const SizedBox(height: 20),

                // Result
                Obx(() {
                  if (controller.selectedPrize.value != null &&
                      !controller.isSpinning.value) {
                    return _buildResultBox(
                        controller.selectedPrize.value!.name);
                  }
                  return const SizedBox.shrink();
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPixelBorder({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF2E7D32), width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildPixelFrame(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF8D6E63),
        border: Border.all(color: const Color(0xFF5D4037), width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(6, 6),
            blurRadius: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildPixelPointer() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD54F),
            border: Border.all(color: const Color(0xFFF57C00), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_downward,
            color: Color(0xFFF57C00),
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildLeverButton({
    required LuckyWheelController controller,
    required bool canSpin,
  }) {
    return Column(
      children: [
        // Instruction text with animation
        if (canSpin && !controller.isSpinning.value)
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: 1 + (sin(value * pi * 2) * 0.1),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD54F),
                    border: Border.all(
                      color: const Color(0xFFF57C00),
                      width: 3,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.touch_app,
                        color: Color(0xFFF57C00),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TAP TO SPIN!',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 10,
                          color: const Color(0xFFF57C00),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

        const SizedBox(height: 16),

        // Main lever button
        GestureDetector(
          onTap: canSpin && !controller.isSpinning.value
              ? () => controller.spin()
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Shadow
                if (canSpin && !controller.isSpinning.value)
                  Positioned(
                    bottom: -6,
                    child: Container(
                      width: 180,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ),

                // Main button body
                Container(
                  width: 180,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: canSpin && !controller.isSpinning.value
                          ? [
                              const Color(0xFFFF6F00),
                              const Color(0xFFE65100),
                            ]
                          : [
                              const Color(0xFF9E9E9E),
                              const Color(0xFF757575),
                            ],
                    ),
                    border: Border.all(
                      color: canSpin && !controller.isSpinning.value
                          ? const Color(0xFFBF360C)
                          : const Color(0xFF616161),
                      width: 5,
                    ),
                    boxShadow: canSpin && !controller.isSpinning.value
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 6),
                              blurRadius: 0,
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Icon(
                        controller.isSpinning.value
                            ? Icons.autorenew
                            : canSpin
                                ? Icons.casino
                                : Icons.schedule,
                        size: 32,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 4),
                      // Text
                      Text(
                        controller.isSpinning.value
                            ? 'SPINNING'
                            : canSpin
                                ? 'SPIN!'
                                : 'LOCKED',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Shine effect when enabled
                if (canSpin && !controller.isSpinning.value)
                  Positioned(
                    top: 8,
                    left: 20,
                    child: Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Status text below
        const SizedBox(height: 12),
        if (!canSpin)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF424242),
              border: Border.all(color: const Color(0xFF212121), width: 2),
            ),
            child: Text(
              'COME BACK TOMORROW',
              style: GoogleFonts.pressStart2p(
                fontSize: 8,
                color: const Color(0xFFBDBDBD),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResultBox(String prize) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF81C784),
        border: Border.all(color: const Color(0xFF2E7D32), width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '★ YOU WON! ★',
            style: GoogleFonts.pressStart2p(
              fontSize: 10,
              color: const Color(0xFFFFD54F),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            prize,
            style: GoogleFonts.pressStart2p(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWheel(LuckyWheelController controller) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Wheel
        CustomPaint(
          size: const Size(280, 280),
          painter: PixelWheelPainter(prizes: controller.prizes),
        ),

        // Center hub
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD54F),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFF57C00), width: 6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.stars_rounded,
            size: 40,
            color: Color(0xFFF57C00),
          ),
        ),
      ],
    );
  }
}

class PixelWheelPainter extends CustomPainter {
  final List prizes;

  PixelWheelPainter({required this.prizes});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sectionAngle = 2 * pi / prizes.length;

    // Pixel art inspired colors
    final colors = [
      const Color(0xFFEF5350), // Red
      const Color(0xFF42A5F5), // Blue
      const Color(0xFF66BB6A), // Green
      const Color(0xFFFFEE58), // Yellow
      const Color(0xFFAB47BC), // Purple
      const Color(0xFFFF7043), // Orange
    ];

    final darkColors = [
      const Color(0xFFC62828),
      const Color(0xFF1565C0),
      const Color(0xFF2E7D32),
      const Color(0xFFF9A825),
      const Color(0xFF6A1B9A),
      const Color(0xFFD84315),
    ];

    for (int i = 0; i < prizes.length; i++) {
      // Main section
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      final startAngle = i * sectionAngle - pi / 2;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        paint,
      );

      // Inner darker shade for depth
      final innerPaint = Paint()
        ..color = darkColors[i % darkColors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.7),
        startAngle,
        sectionAngle,
        true,
        innerPaint,
      );

      // Thick pixel border
      final borderPaint = Paint()
        ..color = const Color(0xFF424242)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        borderPaint,
      );

      // Text with pixel font style
      final textAngle = startAngle + sectionAngle / 2;
      final textRadius = radius * 0.85;
      final textX = center.dx + textRadius * cos(textAngle);
      final textY = center.dy + textRadius * sin(textAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: prizes[i].name,
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: 8,
            shadows: [
              const Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      canvas.save();
      canvas.translate(textX, textY);
      canvas.rotate(textAngle + pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }

    // Outer rim
    final rimPaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, rimPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
