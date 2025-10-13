import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/shop/view/components/container/shop_body_background.dart';
import 'package:trainee/modules/features/shop/view/components/container/shop_body_musik.dart';
import 'package:trainee/modules/features/shop/view/components/container/shop_body_pot.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:flutter/material.dart';
import 'package:trainee/utils/services/hive_service.dart';

class ShopController extends GetxController {
  static ShopController get to => Get.find();

  RxList shopChips = [].obs;
  RxList<dynamic> shopItems = [].obs;
  RxList<dynamic> potItems = [].obs;
  RxList<dynamic> musikItems = [].obs;
  RxList<dynamic> backgroundItems = [].obs;

  RxList<String> shopChip = [
    "Pot",
    "Music",
    "Background",
  ].obs;

  RxInt shopIndex = 0.obs;

  @override
  onInit() {
    super.onInit();
    fetchShopItems();
  }

  Future<void> fetchShopItems() async {
    final result = await DioService.dioCall().get('Shop_items');
    shopItems.value = result.data;

    potItems.value =
        shopItems.where((items) => items['kategori'] == 'pot').toList();

    musikItems.value =
        shopItems.where((items) => items['kategori'] == 'musik').toList();

    backgroundItems.value =
        shopItems.where((items) => items['kategori'] == 'background').toList();
  }

  Future<void> buyItem(String itemId) async {
    try {
      // Update item status in the API
      final itemHarga =
          shopItems.firstWhere((element) => element['id'] == itemId);
      final price = itemHarga['harga'] as int;
      if (IotController.to.coinValue.value < price) {
        return;
      }

      await DioService.dioCall().put('Shop_items/$itemId', data: {'status': 1});

      // Get items to save
      var itemToSave = shopItems.firstWhere((item) => item['id'] == itemId);

      // Get existing items
      List existingItems = HiveService.to.read('shopItems') ?? [];
      existingItems.add(itemToSave);

      // Save updated list
      HiveService.to.save('shopItems', existingItems);

      // Refetch all items to refresh the lists
      await fetchShopItems();
    } catch (e) {
      debugPrint('Error updating item status: $e');
    }
  }

  Color parseBackgroundColor(String color) {
    String colorHex = color;

    return Color(
        int.parse(colorHex.replaceFirst('#', ''), radix: 16) + 0xFF000000);
  }

  void changeShopIndex(int index) {
    shopIndex.value = index;
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return const ShopBodyPot();
      case 1:
        return const ShopBodyMusik();
      case 2:
        return const ShopBodyBackground();
      default:
        return const ShopBodyPot();
    }
  }
}
