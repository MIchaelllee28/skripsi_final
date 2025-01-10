import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TutorialMenanamSawi extends StatelessWidget {
  const TutorialMenanamSawi({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(TutorialController.to
                        .sawiData[TutorialController.to.sayuranIndex.value - 1]
                    ['foto']),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      TutorialController.to.sawiData[
                              TutorialController.to.sayuranIndex.value - 1]
                          ['sayur'],
                      style: GoogleTextStyle.fw500.copyWith(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 50, 140, 91),
                      ),
                    ),
                    Text(
                      "Level ${TutorialController.to.sawiData[TutorialController.to.sayuranIndex.value - 1]['level'].toString()}",
                      style: GoogleTextStyle.fw500.copyWith(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 50, 140, 91),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 14,
                ),
                Image.asset(TutorialController.to
                        .sawiData[TutorialController.to.sayuranIndex.value - 1]
                    ['foto']),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Column(
              children: [
                Text(
                  TutorialController.to.sawiData[
                      TutorialController.to.sayuranIndex.value - 1]['tahap'],
                  style: GoogleTextStyle.fw300.copyWith(
                    color: const Color.fromARGB(255, 50, 140, 91),
                    fontSize: 20,
                  ),
                ),
                Text(
                  TutorialController.to.sawiData[
                      TutorialController.to.sayuranIndex.value - 1]['waktu'],
                  style: GoogleTextStyle.fw300.copyWith(
                    color: const Color.fromARGB(255, 50, 140, 91),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: HtmlWidget(
                TutorialController.to
                        .sawiData[TutorialController.to.sayuranIndex.value - 1]
                    ['deskripsi'],
                textStyle: GoogleTextStyle.fw300.copyWith(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
