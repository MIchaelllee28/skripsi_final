import 'package:flutter/material.dart';
import 'package:trainee/modules/features/Iot/view/components/app_bar.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_hints.dart';
import 'package:trainee/modules/features/shop/view/components/shop_body.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarIot(),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(255, 54, 140, 91),
        child: Stack(
          children: const [
            Center(
              child: ShopBody(),
            ),
          ],
        ),
      ),
      bottomSheet: const BottomHints(),
    );
  }
}
