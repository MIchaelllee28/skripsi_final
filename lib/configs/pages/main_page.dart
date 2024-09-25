import 'package:get/route_manager.dart';
import 'package:trainee/modules/features/counter/binddings/iot_bindings.dart';
import 'package:trainee/modules/features/counter/views/ui/iot_view.dart';
import 'package:trainee/modules/features/counter/views/ui/splash_screen_view.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.initial,
      page: () => const SplashScreenView(),
      binding: ConterBindding(),
    ),
    GetPage(
      name: MainRoute.iot,
      page: () => const IotView(),
      binding: IotBindings(),
    ),
  ];
}
