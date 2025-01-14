import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_body_part_iot.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/right_bottom_arrow.dart';
import 'package:trainee/modules/features/Iot/view/components/top_body_part_iot.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class BodyIot extends StatelessWidget {
  const BodyIot({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const TopBodyPart(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background table image
                  Image.asset(
                    'lib/assets/images/iot/main_part/table_real.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'lib/assets/images/iot/main_part/plant_level_1.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  Positioned(
                    bottom: 220,
                    left: 0,
                    right: 0,
                    child: Obx(() => Image.asset(
                          IotController.to.potSkinPath.value == ''
                              ? 'lib/assets/images/iot/main_part/pot_basic.png'
                              : IotController.to.potSkinPath.value,
                          width: 130,
                          height: 150,
                        )),
                  ),
                  Positioned(
                    bottom: 170,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        // Enhanced Day Counter Design
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.white.withOpacity(0.3),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            "Hari ke 1",
                            style: GoogleTextStyle.fw300.copyWith(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Previous Vegetable Level Container
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const BottomBodyPart(),
            const SizedBox(
              height: 55,
            )
          ],
        ),
        Positioned(
          bottom: 530,
          left: 250,
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.7),
                      Colors.green.withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Sawi ",
                        style: GoogleTextStyle.fw300.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Lv1",
                        style: GoogleTextStyle.fw300.copyWith(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RightArrow(onTap: () {})
            ],
          ),
        ),
      ],
    );
  }
}
