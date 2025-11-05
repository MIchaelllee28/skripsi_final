import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  void preloadImages(BuildContext context) {
    precacheImage(
        const AssetImage('assets/images/mainmenu/backround.png'), context);
    // Add more images to preload as needed
  }

  void moveToMainMenu() {
    Get.offAllNamed(MainRoute.main,
        arguments: 'assets/images/mainmenu/backround.png');
  }
}
