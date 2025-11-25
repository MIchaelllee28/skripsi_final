import 'package:flutter/material.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class LuckyWheelButton extends StatelessWidget {
  const LuckyWheelButton({super.key});

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
                IotController.to.buttonMove(Buttons.luckyWheel);
              },
              icon: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD54F),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFF57C00),
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.casino,
                  size: 40,
                  color: Color(0xFFF57C00),
                ),
              ),
            ),
          ),
          Text(
            "Lucky Spin",
            style: GoogleTextStyle.fw200
                .copyWith(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
