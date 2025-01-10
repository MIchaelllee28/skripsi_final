import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/main_menu/controllers/main_menu_controller.dart';
import 'package:trainee/modules/features/main_menu/view/components/button_back.dart';
import 'package:trainee/modules/features/main_menu/view/components/hint_menu.dart';
import 'package:trainee/modules/features/main_menu/view/components/menu_sidebar.dart';
import 'package:trainee/modules/features/main_menu/view/components/menu_tanam.dart';
import 'package:trainee/modules/features/main_menu/view/components/settings_menu.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    String imageUrl = Get.arguments;
    return Obx(
      () => Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const Expanded(
                flex: 3,
                child: MenuSidebar(),
              ),
              Expanded(
                flex: 4,
                child: MainMenuController.to.navbarNumber.value == 0
                    ? const MenuTanam()
                    : MainMenuController.to.navbarNumber.value == 1
                        ? const SettingsMenu()
                        : const HintsMenu(),
              ),
              const Expanded(
                flex: 1,
                child: ButtonBack(),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
