import 'package:get/get.dart';
import 'package:trainee/modules/features/main_menu/controllers/main_menu_controller.dart';

class MenuBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MainMenuController());
  }
}
