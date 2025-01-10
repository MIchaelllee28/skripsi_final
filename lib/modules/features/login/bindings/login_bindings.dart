import 'package:get/get.dart';
import 'package:trainee/modules/features/login/controllers/login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
