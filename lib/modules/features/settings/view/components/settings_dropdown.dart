import 'package:flutter/material.dart';
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
                keyDrop == 'language'
                    ? 'English'
                    : SettingsController.to.selectedItem[keyDrop]?['name'] ??
                        'loading...',
                style: TextStyle(color: Colors.grey[600]),
              ),
              IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.green[700],
                ),
                onPressed: () {
                  SettingsController.to.dropDownMenu(keyDrop);
                },
              ),
            ],
          ),
        ),
        if (isOpened == true)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(options[index]['nama']),
                onTap: () {
                  SettingsController.to.selectItems(index, options, keyDrop);
                },
              );
            },
          ),
      ],
    );
  }
}
