import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/trophy/controllers/trophy_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class TrophyContent extends StatelessWidget {
  const TrophyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            "Trophy ${TrophyController.to.getTrophy()[0]['kategori']}",
            style: GoogleTextStyle.fw500.copyWith(
              color: const Color.fromARGB(255, 51, 170, 59),
              fontSize: 45,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                              TrophyController.to.getTrophy()[index]['trophy']),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.only(left: 8),
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: Text(
                              TrophyController.to.getTrophy()[index]
                                  ['deskripsi'],
                              style: GoogleTextStyle.fw500.copyWith(
                                color: Colors.black,
                                fontSize: 24,
                                overflow: TextOverflow.clip,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              TrophyController.to.claimTrophy(
                                  TrophyController.to.getTrophy()[index]['id']);
                            },
                            child: Container(
                              height: 35,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/iot/app_bar/coin.png', // Replace with your coin image path
                                    width: 15,
                                    height: 15,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    TrophyController.to.getTrophy()[index]
                                                ['status'] ==
                                            1
                                        ? 'Claimed'
                                        : "500",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
