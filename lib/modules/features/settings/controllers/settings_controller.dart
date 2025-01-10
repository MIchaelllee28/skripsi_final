// settings_controller.dart
import 'package:get/get.dart';
import 'package:trainee/utils/services/hive_service.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  RxList<dynamic> itemsOwned = [].obs;
  RxList<dynamic> potOwned = [].obs;
  RxList<dynamic> musicOwned = [].obs;
  RxList<dynamic> backgroundOwned = [].obs;

  RxMap<String, bool> dropDown = {
    'language': false,
    'pot': false,
    'music': false,
    'background': false,
  }.obs;

  @override
  void onInit() async {
    itemsOwned.value = await HiveService.to.read('shopItems') ?? [].obs;
    initItems();
    super.onInit();
  }

  Future<void> initItems() async {
    potOwned.value =
        itemsOwned.where((item) => item['kategori'] == 'pot').toList();
    musicOwned.value =
        itemsOwned.where((item) => item['kategori'] == 'musik').toList();
    backgroundOwned.value =
        itemsOwned.where((item) => item['kategori'] == 'background').toList();
  }

  void dropDownMenu(String keyDrop) {
    switch (keyDrop) {
      case 'languange':
        dropDown['language'] = !dropDown['language']!;
        break;
      case 'pot':
        dropDown['pot'] = !dropDown['pot']!;
        break;
      case 'music':
        dropDown['music'] = !dropDown['music']!;
        break;
      case 'background':
        dropDown['background'] = !dropDown['background']!;
        break;
    }
  }
}
