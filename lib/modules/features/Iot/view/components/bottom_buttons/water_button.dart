import 'package:flutter/material.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class WaterButton extends StatelessWidget {
  const WaterButton({super.key});

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
                IotController.to.buttonMove(Buttons.water);
              },
              icon: Image.asset(
                "assets/images/iot/buttons/water_button.png",
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "Water",
            style: GoogleTextStyle.fw200
                .copyWith(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
