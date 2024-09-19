import 'package:get/get.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    navigateToMain();
    super.onReady();
  }

  Future navigateToMain() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => const ConterView());
  }
}
