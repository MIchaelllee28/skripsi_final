import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class WaterDetailsDialog extends StatelessWidget {
  const WaterDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Water Data',
                  style: GoogleTextStyle.fw400.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 101, 154, 224),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() => Column(
                  children: [
                    _buildDataRow('1. CO₂ Concentration',
                        '${IotController.to.airCO2} ppm'),
                    _buildDataRow('2. Soil pH', '${IotController.to.airPH}'),
                    _buildDataRow(
                        '3. Air Humidity', '${IotController.to.airHumidity}%'),
                    _buildDataRow(
                        '4. Temperature', '${IotController.to.airTemp}°C'),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleTextStyle.fw400.copyWith(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: GoogleTextStyle.fw400.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 101, 154, 224),
            ),
          ),
        ],
      ),
    );
  }
}
