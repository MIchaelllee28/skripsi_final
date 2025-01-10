import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HintsMenu extends StatelessWidget {
  const HintsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Center(
            child: Container(
              width: 370,
              height: 600,
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 166, 217, 196),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 240,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("lib/assets/images/mainmenu/hint.png"),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Hints",
                            style: GoogleFonts.caveatBrush(
                                color: const Color.fromARGB(255, 19, 100, 121),
                                fontWeight: FontWeight.w500,
                                fontSize: 42),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "lib/assets/images/mainmenu/hint.png",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: 340,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 11, 49, 62),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Hi Farmers!",
                            style: GoogleFonts.caveatBrush(
                              color: Colors.white,
                              fontSize: 33,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 320,
                            child: Text(
                              "Pada tahap ini, kamu diharuskan untuk memilih salah satu dari 4 tanaman yang tersedia untuk kamu tanam baru atau kamu lanjutkan pembudidayaannya :)",
                              style: GoogleFonts.caveatBrush(
                                color: Colors.white,
                                fontSize: 27,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
