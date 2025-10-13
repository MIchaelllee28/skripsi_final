import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/home/controllers/auth_controller.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    AuthController.to.preloadImages(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/images/auth/backround.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 70,
            ),
            const Image(
              image: AssetImage("lib/assets/images/auth/game_title.png"),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: authController.moveToMainMenu,
              child: const Image(
                image: AssetImage("lib/assets/images/auth/continue_button.png"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: const Image(
                image: AssetImage("lib/assets/images/auth/logout_button.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
