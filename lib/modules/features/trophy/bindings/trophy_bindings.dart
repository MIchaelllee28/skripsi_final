import 'package:get/get.dart';
import 'package:trainee/modules/features/trophy/controllers/trophy_controller.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';

class TrophyBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TrophyController());
    Get.put(IotController());
    Get.put(TutorialController());
  }
}
