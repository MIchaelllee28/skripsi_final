import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/splash_screen/controllers/splash_controller.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.put(SplashController());
    return GetBuilder<SplashController>(
      init: controller,
      builder: (context) => Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1B5E20), // Deep forest green
                Color(0xFF1B5E20), // Rich green
                Color(0xFF1B5E20), // Vibrant green
                Color(0xFF66BB6A), // Bright yellow (sunshine)
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -80,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
              ),
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  // Animated plant container with glow effect
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFEB3B).withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          'assets/images/iot/main_part/pot_basic.png',
                          height: 180,
                        ),
                        Positioned(
                          bottom: 120,
                          child: Image.asset(
                            'assets/images/iot/main_part/plant_level_1.png',
                            height: 110,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Game title with gradient text effect
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFFFFFFFF),
                        Color(0xFFFFEB3B),
                      ],
                    ).createShader(bounds),
                    child: Text(
                      'TANI',
                      style: GoogleFonts.fredoka(
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 4),
                            blurRadius: 8,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Subtitle with icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.eco,
                        color: Color(0xFFFFEB3B),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Grow & Learn Together',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.eco,
                        color: Color(0xFFFFEB3B),
                        size: 20,
                      ),
                    ],
                  ),
                  const Spacer(flex: 3),
                  // Custom loading indicator
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFFFFEB3B),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
