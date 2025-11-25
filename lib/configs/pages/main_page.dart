import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/bindings/iot_bindings.dart';
import 'package:trainee/modules/features/Iot/view/ui/iot_view.dart';
import 'package:trainee/modules/features/home/view/ui/home_view.dart';
import 'package:trainee/modules/features/login/view/ui/login_view.dart';
import 'package:trainee/modules/features/main_menu/bindings/menu_bindings.dart';
import 'package:trainee/modules/features/main_menu/view/ui/main_menu_view.dart';
import 'package:trainee/modules/features/settings/view/ui/settings_view.dart';
import 'package:trainee/modules/features/shop/view/ui/shop_view.dart';
import 'package:trainee/modules/features/splash_screen/view/ui/splash_screen_view.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/home/bindings/auth_binding.dart';
import 'package:trainee/modules/features/login/bindings/login_bindings.dart';
import 'package:trainee/modules/features/trophy/view/ui/trophy_view.dart';
import 'package:trainee/modules/features/trophy/bindings/trophy_bindings.dart';
import 'package:trainee/modules/features/tutorial/view/ui/tutorial_view.dart';
import 'package:trainee/modules/features/shop/bindings/shop_bindings.dart';
import 'package:trainee/modules/features/tutorial/bindings/tutorial_bindings.dart';
import 'package:trainee/modules/features/settings/bindings/settings_bindings.dart';
import 'package:trainee/modules/features/lucky_wheel/view/ui/lucky_wheel_view.dart';
import 'package:trainee/modules/features/lucky_wheel/bindings/lucky_wheel_binding.dart';

abstract class MainPage {
  static final main = [
    GetPage(
      name: MainRoute.splash,
      page: () => const SplashScreenView(),
    ),
    GetPage(
      name: MainRoute.home,
      page: () => const AuthView(),
      binding: AuthBindings(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: MainRoute.main,
      page: () => const MainMenuView(),
      binding: MenuBindings(),
      transition: Transition.cupertinoDialog,
      transitionDuration: const Duration(seconds: 1),
    ),
    GetPage(
      name: MainRoute.iot,
      page: () => const IotView(),
      binding: IotBindings(),
    ),
    GetPage(
      name: MainRoute.login,
      page: () => const LoginView(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: MainRoute.shop,
      page: () => const ShopView(),
      binding: ShopBindings(),
    ),
    GetPage(
      name: MainRoute.tutorial,
      page: () => const TutorialView(),
      binding: TutorialBindings(),
    ),
    GetPage(
      name: MainRoute.trophy,
      page: () => const TrophyView(),
      binding: TrophyBindings(),
    ),
    GetPage(
      name: MainRoute.settings,
      page: () => const SettingsView(),
      binding: SettingsBindings(),
    ),
    GetPage(
      name: MainRoute.luckyWheel,
      page: () => const LuckyWheelView(),
      binding: LuckyWheelBinding(),
    ),
  ];
}
