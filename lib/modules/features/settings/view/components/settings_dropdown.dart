import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/settings/controllers/settings_controller.dart';

class SettingsDropdown extends StatelessWidget {
  final String title;
  final List<String> options;
  final String settingKey;

  const SettingsDropdown({
    super.key,
    required this.title,
    required this.options,
    required this.settingKey,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find();

    return Obx(() {
      final isExpanded = _getExpandedValue(controller);
      final selectedValue = _getSelectedValue(controller);

      return Column(
        children: [
          ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
                fontSize: 18,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedValue,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.green[700],
                  ),
                  onPressed: () => controller.toggleExpand(settingKey),
                ),
              ],
            ),
          ),
          if (isExpanded)
            Column(
              children: options.map((option) {
                return ListTile(
                  title: Text(option),
                  onTap: () => controller.selectOption(settingKey, option),
                  tileColor: selectedValue == option ? Colors.green[50] : null,
                );
              }).toList(),
            ),
          const Divider(height: 1),
        ],
      );
    });
  }

  bool _getExpandedValue(SettingsController controller) {
    switch (settingKey) {
      case 'language':
        return controller.isLanguageExpanded.value;
      case 'potSkin':
        return controller.isPotSkinExpanded.value;
      case 'background':
        return controller.isBackgroundExpanded.value;
      case 'music':
        return controller.isMusicExpanded.value;
      default:
        return false;
    }
  }

  String _getSelectedValue(SettingsController controller) {
    switch (settingKey) {
      case 'language':
        return controller.selectedLanguage.value;
      case 'potSkin':
        return controller.selectedPotSkin.value;
      case 'background':
        return controller.selectedBackground.value;
      case 'music':
        return controller.selectedMusic.value;
      default:
        return '';
    }
  }
}
