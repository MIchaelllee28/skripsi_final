import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';

class IotBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(IotController());
  }
}
