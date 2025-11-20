import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';

class ActuatorControlDialog extends StatelessWidget {
  const ActuatorControlDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Control Actuators',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Lamp Slider
                    Obx(() => Column(
                          children: [
                            Text('Lamp: ${IotController.to.lampState}%'),
                            Slider(
                              value: IotController.to.lampState.toDouble(),
                              min: 0,
                              max: 100,
                              onChanged: (value) =>
                                  IotController.to.setLampValue(value.toInt()),
                            ),
                          ],
                        )),

                    // pH Down Slider
                    Obx(() => Column(
                          children: [
                            Text('pH Down: ${IotController.to.phDownState}%'),
                            Slider(
                              value: IotController.to.phDownState.toDouble(),
                              min: 0,
                              max: 100,
                              onChanged: (value) => IotController.to
                                  .setPhDownValue(value.toInt()),
                            ),
                          ],
                        )),

                    // pH Up Slider
                    Obx(() => Column(
                          children: [
                            Text('pH Up: ${IotController.to.phUpState}%'),
                            Slider(
                              value: IotController.to.phUpState.toDouble(),
                              min: 0,
                              max: 100,
                              onChanged: (value) =>
                                  IotController.to.setPhUpValue(value.toInt()),
                            ),
                          ],
                        )),

                    // Pump Slider
                    Obx(() => Column(
                          children: [
                            Text('Pump: ${IotController.to.pumpState}%'),
                            Slider(
                              value: IotController.to.pumpState.toDouble(),
                              min: 0,
                              max: 100,
                              onChanged: (value) =>
                                  IotController.to.setPumpValue(value.toInt()),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
