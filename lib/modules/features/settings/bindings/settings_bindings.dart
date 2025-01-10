import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/settings/controllers/settings_controller.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/hive_service.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(DioService());
    Get.put(HiveService());
    Get.put(SettingsController());
    Get.put(IotController());
  }
}
