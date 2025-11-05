import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/modules/features/main_menu/controllers/main_menu_controller.dart';

class MenuTanam extends StatelessWidget {
  const MenuTanam({super.key});

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
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Apakah Sudah Menanam Tanaman?',
                    style: GoogleFonts.caveatBrush(
                        color: const Color.fromARGB(255, 19, 121, 68),
                        fontSize: 40.r,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: MainMenuController.to.iotScreen,
                    child: Container(
                      width: 160,
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
                            "Sudah",
                            style: GoogleFonts.caveatBrush(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 32),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Image.asset("assets/images/mainmenu/checklist.png"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'atau',
                    style: GoogleFonts.caveatBrush(
                        color: const Color.fromARGB(255, 10, 48, 61),
                        fontWeight: FontWeight.bold,
                        fontSize: 32.r),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    child: Container(
                      width: 240,
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
                            "Lihat Tutorial",
                            style: GoogleFonts.caveatBrush(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 32),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Image.asset("assets/images/mainmenu/book.png"),
                        ],
                      ),
                    ),
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
