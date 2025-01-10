import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/shop/controllers/shop_controller.dart';
import 'package:trainee/utils/services/hive_service.dart';

class ShopBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(HiveService());
    Get.put(ShopController());
    Get.put(IotController());
  }
}
