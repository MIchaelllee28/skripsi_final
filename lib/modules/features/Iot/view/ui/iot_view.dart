import 'package:flutter/material.dart';
import 'package:trainee/modules/features/Iot/view/components/app_bar.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_hints.dart';
import 'package:trainee/modules/features/Iot/view/components/iot_body.dart';

class IotView extends StatelessWidget {
  const IotView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBarIot(),
      body: BodyIot(),
      bottomSheet: BottomHints(),
    );
  }
}
