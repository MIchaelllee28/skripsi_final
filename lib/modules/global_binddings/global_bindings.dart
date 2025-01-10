import 'package:get/get.dart';
import 'package:trainee/modules/global_controllers/network_controller.dart';
import 'package:trainee/utils/services/hive_service.dart';

class GlobalBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HiveService());
    Get.put(NetworkController());
  }
}
