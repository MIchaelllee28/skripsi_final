import 'package:flutter/material.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TutorialButton extends StatelessWidget {
  const TutorialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: IconButton(
              onPressed: () {
                IotController.to.buttonMove(Buttons.tutorial);
              },
              icon: Image.asset(
                "lib/assets/images/iot/buttons/tutorial_button.png",
                height: 70,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "Tutorial",
            style: GoogleTextStyle.fw200
                .copyWith(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
