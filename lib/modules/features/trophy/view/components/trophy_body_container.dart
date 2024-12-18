import 'package:flutter/material.dart';
import 'package:trainee/modules/features/trophy/view/components/content/trophy_content.dart';

class TrophyBodyContainer extends StatelessWidget {
  const TrophyBodyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Padding(
        padding: EdgeInsets.only(bottom: 75),
        child: TrophyContent(),
      ),
    );
  }
}
