import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
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
                            Image.asset("assets/images/mainmenu/setting.png"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Settings",
                              style: GoogleFonts.caveatBrush(
                                  color:
                                      const Color.fromARGB(255, 19, 100, 121),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 42),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/images/mainmenu/setting.png",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        width: 270,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 6, 29, 45),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Music Playing : Disco",
                              style: GoogleFonts.caveatBrush(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        width: 270,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 6, 29, 45),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Background : Green Forrest",
                              style: GoogleFonts.caveatBrush(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        width: 270,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 6, 29, 45),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Game Languange : English",
                              style: GoogleFonts.caveatBrush(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
