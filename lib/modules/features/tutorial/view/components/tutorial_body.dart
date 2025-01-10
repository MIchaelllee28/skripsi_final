import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';
import 'package:trainee/modules/features/tutorial/view/components/body_container.dart';
import 'package:trainee/modules/features/tutorial/view/components/chip_tutorial.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TutorialBody extends StatelessWidget {
  const TutorialBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Tutorial",
          style: GoogleTextStyle.fw400.copyWith(
            fontSize: 52,
            color: MainColor.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                    width: 7,
                  ),
              itemBuilder: (context, index) {
                return Obx(() => ChipTutorial(
                      backgroundColor:
                          TutorialController.to.chipIndex.value == index + 1
                              ? 1
                              : 0,
                      imageUrl: TutorialController.to.chipData[index]['foto'],
                      onTap: () {
                        TutorialController.to.changeChip(index);
                      },
                    ));
              }),
        ),
        const SizedBox(
          height: 30,
        ),
        const Expanded(flex: 10, child: BodyContainer()),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
