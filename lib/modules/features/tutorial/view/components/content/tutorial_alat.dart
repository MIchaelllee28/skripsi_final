import 'package:flutter/material.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TutorialAlat extends StatelessWidget {
  const TutorialAlat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "Alat Dan Bahan",
                style: GoogleTextStyle.fw500.copyWith(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              Text(
                "yang dibutuhkan :",
                style: GoogleTextStyle.fw500.copyWith(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 35),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${(index + 1).toString()}.',
                      style: GoogleTextStyle.fw400.copyWith(fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 190),
                      child: Text(
                        "Benih kangkung, sawi, atau selada",
                        style: GoogleTextStyle.fw500.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Image.asset("lib/assets/images/iot/app_bar/coin.png")
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
