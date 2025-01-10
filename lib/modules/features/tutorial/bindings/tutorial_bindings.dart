import 'package:get/get.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';

class TutorialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TutorialController());
    Get.put(IotController());
  }
}
