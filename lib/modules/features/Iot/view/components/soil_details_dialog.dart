import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class SoilDetailsDialog extends StatelessWidget {
  const SoilDetailsDialog({super.key});

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
                  'Soil Data',
                  style: GoogleTextStyle.fw400.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 145, 130, 145),
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
                    _buildDataRow(
                        '1. Humidity', '${IotController.to.soilHumidity}%'),
                    _buildDataRow(
                        '2. Temperature', '${IotController.to.soilTemp}°C'),
                    _buildDataRow('3. Electrical Conductivity',
                        '${IotController.to.soilEC} mS/cm'),
                    _buildDataRow(
                        '4. Acidity (pH)', '${IotController.to.soilPH}'),
                    _buildDataRow(
                        '5. Nitrogen (N)', '${IotController.to.soilN} mg/kg'),
                    _buildDataRow(
                        '6. Phosphorus (P)', '${IotController.to.soilP} mg/kg'),
                    _buildDataRow(
                        '7. Potassium (K)', '${IotController.to.soilK} mg/kg'),
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
              color: const Color.fromARGB(255, 145, 130, 145),
            ),
          ),
        ],
      ),
    );
  }
}
