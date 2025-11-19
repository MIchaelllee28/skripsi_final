import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:trainee/modules/features/Iot/view/components/soil_details_dialog.dart';
import 'package:trainee/modules/features/Iot/view/components/water_details_dialog.dart';

class AppBarIot extends StatelessWidget implements PreferredSizeWidget {
  const AppBarIot({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        backgroundColor: const Color.fromARGB(125, 119, 216, 123),
        actions: [
          const SizedBox(
            width: 12,
          ),
          TextButton.icon(
            //TODO : add proper function
            onPressed: () {}, //IotController.to.toogleRelay1,
            icon: Image.asset("assets/images/iot/app_bar/coin.png", height: 27),
            label: Text(
              IotController.to.coinValue.value.toString(),
              style: GoogleTextStyle.fw400.copyWith(
                fontSize: 25,
                color: const Color.fromARGB(
                  255,
                  195,
                  120,
                  8,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          TextButton.icon(
            onPressed: () => Get.dialog(const SoilDetailsDialog()),
            icon: Image.asset("assets/images/iot/app_bar/soil.png", height: 27),
            label: Text(
              '${IotController.to.soilHumidity.toStringAsFixed(1)}%',
              style: GoogleTextStyle.fw400.copyWith(
                fontSize: 25,
                color: const Color.fromARGB(
                  255,
                  145,
                  130,
                  145,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          TextButton.icon(
            onPressed: () => Get.dialog(const WaterDetailsDialog()),
            icon:
                Image.asset("assets/images/iot/app_bar/water.png", height: 27),
            label: IotController.to.liquidValue == true
                ? Text(
                    "Good",
                    style: GoogleTextStyle.fw400.copyWith(
                      fontSize: 25,
                      color: const Color.fromARGB(
                        255,
                        101,
                        154,
                        224,
                      ),
                    ),
                  )
                : Text(
                    "Fill",
                    style: GoogleTextStyle.fw400.copyWith(
                      fontSize: 25,
                      color: const Color.fromARGB(255, 227, 17, 17),
                    ),
                  ),
          ),
          const SizedBox(
            width: 80,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
