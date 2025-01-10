import 'package:flutter/material.dart';
import 'package:trainee/modules/features/tutorial/controllers/tutorial_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TutorialIcon extends StatelessWidget {
  const TutorialIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Penjelasan Icon",
          style: GoogleTextStyle.fw500.copyWith(
            color: Colors.black,
            fontSize: 32,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          TutorialController.to.iconsData[index]['foto']),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 8),
                        constraints: const BoxConstraints(maxWidth: 190),
                        child: Text(
                          TutorialController.to.iconsData[index]['deskripsi'],
                          style: GoogleTextStyle.fw500.copyWith(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
