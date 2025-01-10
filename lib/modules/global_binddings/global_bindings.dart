import 'package:get/get.dart';
import 'package:trainee/modules/global_controllers/network_controller.dart';

class GlobalBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController());
  }
}
