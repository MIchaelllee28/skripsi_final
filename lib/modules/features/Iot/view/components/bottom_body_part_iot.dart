import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/left_bottom_arrow.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/right_bottom_arrow.dart';

class BottomBodyPart extends StatelessWidget {
  const BottomBodyPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 80,
        ),
        Expanded(
          child: LeftArrow(
            onTap: () {
              IotController.to.changeButton(Directions.left);
            },
          ),
        ),
        Obx(
          () => Expanded(
            child: IotController.to
                .getButtons(IotController.to.toogleButton.value),
          ),
        ),
        Expanded(
          child: RightArrow(onTap: () {
            IotController.to.changeButton(Directions.right);
          }),
        ),
        const SizedBox(
          width: 80,
        ),
      ],
    );
  }
}
