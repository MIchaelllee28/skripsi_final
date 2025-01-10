import 'package:flutter/material.dart';
import 'package:trainee/modules/features/main_menu/controllers/main_menu_controller.dart';

class MenuSidebar extends StatelessWidget {
  const MenuSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 30,
          left: 335, // Adjust this value to move the container horizontally
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 59, 148, 98),
            ),
            width: 60,
            height: 240,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    MainMenuController.to.homeButton();
                  },
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Home",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {
                    MainMenuController.to.settingsButton();
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Settings",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {
                    MainMenuController.to.hintButton();
                  },
                  icon: const Icon(
                    Icons.book,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Hint",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
