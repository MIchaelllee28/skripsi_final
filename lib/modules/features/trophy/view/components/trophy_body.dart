import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/trophy/controllers/trophy_controller.dart';
import 'package:trainee/modules/features/trophy/view/components/chip_trophy.dart';
import 'package:trainee/modules/features/trophy/view/components/trophy_body_container.dart';

class TrophyBody extends StatelessWidget {
  const TrophyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                    width: 7,
                  ),
              itemBuilder: (context, index) {
                return Obx(
                  () => ChipTrophy(
                    backgroundColor:
                        TrophyController.to.trophyIndex.value == index ? 1 : 0,
                    imageUrl: TrophyController.to.trophyChipData[index]["foto"],
                    onTap: () {
                      TrophyController.to.changeTrophyIndex(index);
                    },
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 30,
        ),
        const Expanded(flex: 10, child: TrophyBodyContainer()),
        const SizedBox(
          height: 100,
        )
      ],
    );
  }
}
