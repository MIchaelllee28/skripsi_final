import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/view/components/app_bar.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_hints.dart';
import 'package:trainee/modules/features/trophy/controllers/trophy_controller.dart';
import 'package:trainee/modules/features/trophy/view/components/trophy_body.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TrophyView extends StatelessWidget {
  const TrophyView({super.key});

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
              child: TrophyBody(),
            ),
            Positioned(
              right: 125,
              bottom: 110,
              child: SizedBox(
                width: 100,
                child: Obx(
                  () => Text(
                    '${TrophyController.to.trophyIndex.value + 1}/3',
                    style: GoogleTextStyle.fw300.copyWith(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 35,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const BottomHints(),
    );
  }
}
