import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/view/components/app_bar.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_hints.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/left_bottom_arrow.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/right_bottom_arrow.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';
import 'package:trainee/modules/features/tutorial/view/components/tutorial_body.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TutorialView extends StatelessWidget {
  const TutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarIot(),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 54, 140, 91),
        child: Stack(
          children: [
            const Center(
              child: TutorialBody(),
            ),
            Positioned(
              left: 0,
              bottom: 60,
              child: SizedBox(
                width: 100,
                child: LeftArrow(onTap: () {
                  TutorialController.to.chipIndex.value == 4 ||
                          TutorialController.to.chipIndex.value == 5
                      ? () {}
                      : TutorialController.to.changeKangkungIndex(0);
                }),
              ),
            ),
            Obx(
              () => Positioned(
                right: 125,
                bottom: 110,
                child: SizedBox(
                  width: 100,
                  child: Text(
                    TutorialController.to.chipIndex.value == 4 ||
                            TutorialController.to.chipIndex.value == 5
                        ? '1/1'
                        : "${TutorialController.to.sayuranIndex.value.toString()}/6",
                    style: GoogleTextStyle.fw300.copyWith(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 60,
              child: SizedBox(
                width: 100,
                child: RightArrow(onTap: () {
                  TutorialController.to.chipIndex.value == 4 ||
                          TutorialController.to.chipIndex.value == 5
                      ? () {}
                      : TutorialController.to.changeKangkungIndex(1);
                }),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const BottomHints(),
    );
  }
}
