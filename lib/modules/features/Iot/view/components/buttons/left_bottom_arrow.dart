import 'package:flutter/material.dart';

class LeftArrow extends StatelessWidget {
  final void Function() onTap;
  const LeftArrow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: SizedBox(
        height: 120,
        child: IconButton(
          onPressed: onTap,
          icon: Image.asset("assets/images/iot/buttons/lefties.png"),
        ),
      ),
    );
  }
}
