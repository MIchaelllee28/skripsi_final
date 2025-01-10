import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class MainMenuController extends GetxController {
  static MainMenuController get to => Get.find();
  final RxInt navbarNumber = 0.obs;

  void moveToMainMenu() {
    Get.toNamed(MainRoute.iot);
  }

  void hintButton() {
    navbarNumber.value = 2;
  }

  void settingsButton() {
    navbarNumber.value = 1;
  }

  void homeButton() {
    Get.offAllNamed(MainRoute.home);
  }

  void backButton() {
    navbarNumber.value = 0;
  }

  void iotScreen() {
    Get.toNamed(MainRoute.iot);
  }
}
