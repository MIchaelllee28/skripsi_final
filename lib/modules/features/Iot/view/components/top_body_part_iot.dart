import 'package:flutter/material.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/left_bottom_arrow.dart';
import 'package:trainee/modules/features/Iot/view/components/buttons/right_bottom_arrow.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TopBodyPart extends StatelessWidget {
  const TopBodyPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 80,
          ),
          Expanded(
            child: LeftArrow(
              onTap: () {},
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 35,
              ),
              child: Text(
                "Calmy Grey",
                style: GoogleTextStyle.fw300.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: RightArrow(
              onTap: () {},
            ),
          ),
          const SizedBox(
            width: 80,
          ),
        ],
      ),
    );
  }
}
