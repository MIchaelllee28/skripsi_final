import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/splash_screen/controllers/splash_controller.dart';
import 'package:trainee/configs/themes/main_color.dart';

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
              colors: [MainColor.primary, MainColor.grey],
            ),
          ),
          child: Center(
            child: Image.asset('assets/images/auth/java_code.png'),
          ),
        ),
      ),
    );
  }
}
