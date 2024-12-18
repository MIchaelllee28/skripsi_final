import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    navigateToMain();
    super.onReady();
  }

  Future navigateToMain() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    Get.toNamed(MainRoute.home);
  }
}
