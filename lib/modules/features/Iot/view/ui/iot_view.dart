import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/Iot/view/components/app_bar.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_hints.dart';
import 'package:trainee/modules/features/Iot/view/components/iot_body.dart';

class IotView extends StatelessWidget {
  const IotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Color.fromARGB(255, IotController.to.r.value,
              IotController.to.g.value, IotController.to.b.value),
          appBar: const AppBarIot(),
          body: const BodyIot(),
          bottomSheet: const BottomHints(),
        ));
  }
}
