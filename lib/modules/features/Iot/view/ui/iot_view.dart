import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:firebase_database/firebase_database.dart';

class IotView extends StatelessWidget {
  const IotView({super.key});

  @override
  Widget build(BuildContext context) {
    IotController iotController = Get.find();
    return MaterialApp(
        home: Obx(
      () => Scaffold(
          body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "${iotController.intValue.value}",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  iotController.printIntValue();
                },
                child: const Text("push")),
            ElevatedButton(
              onPressed: iotController.toogleRelay,
              child: const Text("push relay"),
            )
          ],
        ),
      )),
    ));
  }
}
