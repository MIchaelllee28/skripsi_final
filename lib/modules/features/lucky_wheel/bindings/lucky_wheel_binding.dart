import 'package:get/get.dart';
import 'package:trainee/modules/features/lucky_wheel/controllers/lucky_wheel_controller.dart';

class LuckyWheelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LuckyWheelController>(() => LuckyWheelController());
  }
}
