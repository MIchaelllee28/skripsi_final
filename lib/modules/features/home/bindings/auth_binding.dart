import 'package:get/get.dart';
import 'package:trainee/modules/features/home/controllers/auth_controller.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
