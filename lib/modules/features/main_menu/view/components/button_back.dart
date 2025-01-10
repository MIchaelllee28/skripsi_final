import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/modules/features/main_menu/controllers/main_menu_controller.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 15,
          left: 160,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 11, 49, 62),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                  child: IconButton(
                    onPressed: MainMenuController.to.backButton,
                    icon: const Icon(
                      Icons.home,
                    ),
                  ),
                ),
                Text(
                  "Back",
                  style: GoogleFonts.caveatBrush(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
