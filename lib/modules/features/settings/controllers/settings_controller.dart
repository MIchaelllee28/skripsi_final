// settings_controller.dart
import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Language settings
  final RxString selectedLanguage = 'English'.obs;
  final RxBool isLanguageExpanded = false.obs;

  // Pot Skin settings
  final RxString selectedPotSkin = 'Classic'.obs;
  final RxBool isPotSkinExpanded = false.obs;

  // Background settings
  final RxString selectedBackground = 'Default'.obs;
  final RxBool isBackgroundExpanded = false.obs;

  // Music settings
  final RxString selectedMusic = 'Calm'.obs;
  final RxBool isMusicExpanded = false.obs;

  void toggleExpand(String setting) {
    switch (setting) {
      case 'language':
        isLanguageExpanded.value = !isLanguageExpanded.value;
        break;
      case 'potSkin':
        isPotSkinExpanded.value = !isPotSkinExpanded.value;
        break;
      case 'background':
        isBackgroundExpanded.value = !isBackgroundExpanded.value;
        break;
      case 'music':
        isMusicExpanded.value = !isMusicExpanded.value;
        break;
    }
  }

  void selectOption(String setting, String option) {
    switch (setting) {
      case 'language':
        selectedLanguage.value = option;
        isLanguageExpanded.value = false;
        break;
      case 'potSkin':
        selectedPotSkin.value = option;
        isPotSkinExpanded.value = false;
        break;
      case 'background':
        selectedBackground.value = option;
        isBackgroundExpanded.value = false;
        break;
      case 'music':
        selectedMusic.value = option;
        isMusicExpanded.value = false;
        break;
    }
  }
}
