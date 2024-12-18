import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/settings/controllers/settings_controller.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
    Get.put(IotController());
  }
}
