import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/view/components/app_bar.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_hints.dart';
import 'package:trainee/modules/features/settings/view/components/settings_dropdown.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarIot(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 54, 140, 91),
              Color.fromARGB(255, 37, 97, 63),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings, color: Colors.green[800], size: 30),
                      const SizedBox(width: 10),
                      Text(
                        'App Settings',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ),
                const SettingsDropdown(
                  title: 'Language',
                  options: ['English', 'Español', 'Français', 'Deutsch'],
                  settingKey: 'language',
                ),
                const SettingsDropdown(
                  title: 'Pot Skin',
                  options: ['Classic', 'Modern', 'Minimalist', 'Vibrant'],
                  settingKey: 'potSkin',
                ),
                const SettingsDropdown(
                  title: 'Background',
                  options: ['Default', 'Nature', 'Urban', 'Abstract'],
                  settingKey: 'background',
                ),
                const SettingsDropdown(
                  title: 'Music',
                  options: ['Calm', 'Energetic', 'Classical', 'Jazz'],
                  settingKey: 'music',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: const BottomHints(),
    );
  }
}
