import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService extends GetxService {
  static HiveService get to => Get.find();
  late Box box;
  late Box selectedBox;
  late Box iotLogicBox;

  @override
  void onInit() async {
    await Hive.initFlutter();
    box = await Hive.openBox('shopItems');
    selectedBox = await Hive.openBox('selectedItems');
    iotLogicBox = await Hive.openBox('iot_logic');
    super.onInit();
  }

  // Save data
  Future<void> save(String key, dynamic value) async {
    await box.put(key, value);
  }

  // Read data
  dynamic read(String key) {
    return box.get(key);
  }

  // Delete data
  Future<void> delete(String key) async {
    await box.delete(key);
  }

  // Clear all data
  Future<void> clearAll() async {
    await box.clear();
    await selectedBox.clear();
  }
}

// Usage Examples:
/*
// 1. Initialize the service in your main.dart or initial binding
void main() async {
  await Get.putAsync(() => HiveService().init());
  runApp(MyApp());
}

// 2. Use the service anywhere in your app
final hiveService = Get.find<HiveService>();

// Save data
await hiveService.save('username', 'John Doe');
await hiveService.save('isLoggedIn', true);
await hiveService.save('userAge', 25);

// Read data
String? username = hiveService.read('username');
bool? isLoggedIn = hiveService.read('isLoggedIn');
int? age = hiveService.read('userAge');

// Delete specific data
await hiveService.delete('username');

// Clear all data
await hiveService.clearAll();
*/
