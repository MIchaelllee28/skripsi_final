import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class BottomHints extends StatelessWidget {
  const BottomHints({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 30, // Increase the elevation for a more raised look
      color: Colors
          .white, // Add a white background to make the shadow more noticeable
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 65, 167, 70),
          // Add rounded corners for a cleaner look
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(
                  0, 3), // Adjust the offset to control the shadow's position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/iot/bottom_bar/lamp.png"),
              SizedBox(
                width: 300,
                child: Obx(
                  () {
                    if (IotController.to.hints.isEmpty) {
                      return const SizedBox(
                        height: 3,
                        width: 10,
                      );
                    }
                    return Text(
                      IotController.to.hints[IotController.to.hintIndex.value]
                              ['hint'] ??
                          'its a null babygirl',
                      style: GoogleTextStyle.fw500.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
