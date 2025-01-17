// settings_controller.dart
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/hive_service.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  RxList<dynamic> itemsOwned = [].obs;
  RxList<dynamic> potOwned = [].obs;
  RxList<dynamic> musicOwned = [].obs;
  RxList<dynamic> backgroundOwned = [].obs;

  RxMap selectedItem = {}.obs;

  RxMap<String, bool> dropDown = {
    'language': false,
    'pot': false,
    'music': false,
    'background': false,
  }.obs;

  @override
  void onInit() async {
    itemsOwned.value = await HiveService.to.read('shopItems') ?? [].obs;
    selectedItem.value =
        await HiveService.to.selectedBox.get('selectedItems') ?? {}.obs;
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

  String getItemsName(String keyDrop) {
    switch (keyDrop) {
      case 'languange':
        return 'English';
      case 'pot':
        return selectedItem['pot']?['name'] ?? 'Select';
      case 'background':
        return selectedItem['background']?['name'] ?? 'Select';
      case 'music':
        return selectedItem['music']?['name'] ?? 'Select';
      default:
        return "select";
    }
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

  // save selected item

  Future<void> selectItems(int index, List items, String keyDrop) async {
    // First, get existing selected items or create new map if none exists
    Map selectedItems =
        await HiveService.to.selectedBox.get('selectedItems') ?? {};

    // Update only the specific key
    selectedItems[keyDrop] = {
      'name': items[index]['nama'],
      'id': items[index]['id'],
      'deskripsi': items[index]['deskripsi'],
    };

    // Save the updated map back to Hive
    await HiveService.to.selectedBox.put('selectedItems', selectedItems);
    selectedItem.value = selectedItems;
    dropDownMenu(keyDrop);
    IotController.to.selectedItems.value =
        HiveService.to.selectedBox.get('selectedItems') ?? {};
    IotController.to.getBackgroundColor();
    IotController.to.getPotSkin();
    IotController.to.getMusic();
  }

  //reset local and api data

  Future<void> reset() async {
    // reset every data to be unowned (status : 0)
    for (var i = 1; i < 16; i++) {
      await DioService.dioCall().put('Shop_items/$i', data: {'status': 0});
    }
    await HiveService.to.clearAll();
    //reinit the items
    onInit();
  }
}
