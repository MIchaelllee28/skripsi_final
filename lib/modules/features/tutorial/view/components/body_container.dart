import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child: TutorialController.to.getTutorialTanaman(),
        ),
      ),
    );
  }
}
