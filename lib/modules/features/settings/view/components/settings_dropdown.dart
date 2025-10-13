import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/settings/controllers/settings_controller.dart';

class SettingsDropdown extends StatelessWidget {
  final String title;
  final List<dynamic> options;
  final bool isOpened;
  final String keyDrop;

  const SettingsDropdown({
    super.key,
    required this.title,
    required this.options,
    required this.isOpened,
    required this.keyDrop,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Obx(
            () => Flexible(
              flex: 5,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String?>(
                  value: _getSelectedValue(keyDrop),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _onItemSelected(newValue, keyDrop);
                    }
                  },
                  hint: Text(
                    'Select',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: options.isNotEmpty ? Colors.black : Colors.grey,
                    ),
                  ),
                  items: options
                      .map(
                        (element) => DropdownMenuItem<String>(
                          value: element['id'], // Store the ID as value
                          child: Text(
                            element['nama'], // Display the name
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String? _getSelectedValue(String keyDrop) {
    final selectedItem = SettingsController.to.selectedItem[keyDrop];
    if (selectedItem != null && selectedItem['id'] != null) {
      return selectedItem['id'].toString(); // Return the ID as string
    }
    return null; // Return null for the "Select" option
  }

  void _onItemSelected(String itemId, String keyDrop) {
    // Find the selected item from options
    final selectedItem = options.firstWhere(
      (element) => element['id'].toString() == itemId,
      orElse: () => {},
    );

    if (selectedItem.isNotEmpty) {
      // Find the index of the selected item
      final index = options.indexWhere(
        (element) => element['id'].toString() == itemId,
      );

      if (index != -1) {
        SettingsController.to.selectItems(index, options, keyDrop);
      }
    }
  }
}
