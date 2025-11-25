import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/shop/repository/shop_repository.dart';
import 'package:trainee/modules/features/shop/view/components/container/shop_body_background.dart';
import 'package:trainee/modules/features/shop/view/components/container/shop_body_musik.dart';
import 'package:trainee/modules/features/shop/view/components/container/shop_body_pot.dart';
import 'package:trainee/modules/features/shop/view/components/success_dialog.dart';
import 'package:trainee/modules/features/shop/view/components/insufficient_funds_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trainee/utils/services/hive_service.dart';

class ShopController extends GetxController {
  static ShopController get to => Get.find();

  RxList shopChips = [].obs;
  RxList<dynamic> shopItems = [].obs;
  RxList<dynamic> potItems = [].obs;
  RxList<dynamic> musikItems = [].obs;
  RxList<dynamic> backgroundItems = [].obs;
  late ShopRepository repository;

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
    repository = ShopRepository();
    shopItems.value =
        repository.initializeShop(HiveService.to.read('shopItems') ?? []);

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
      if (itemId == '11') {
        IotController.to.addCoins(amount: 500);
        Get.showSnackbar(
          GetSnackBar(
            title: 'Got Coin',
            message: 'Got 500 coin from this item as reward',
            animationDuration: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 1200),
            icon: Icon(
              Icons.monetization_on_rounded,
              color: Colors.green.shade800,
              size: 20,
            ),
          ),
        );
        return;
      }

      final itemHarga =
          shopItems.firstWhere((element) => element['id'] == itemId);
      final price = itemHarga['harga'] as int;
      if (IotController.to.coinValue.value < price) {
        Get.dialog(
          InsufficientFundsDialog(
            requiredCoins: price,
            currentCoins: IotController.to.coinValue.value,
          ),
        );
        return;
      }

      IotController.to.reduceCoins(price);

      // Get items to save and mark as owned
      var itemToSave = Map<String, dynamic>.from(
          shopItems.firstWhere((item) => item['id'] == itemId));
      itemToSave['status'] = 1; // Mark as owned

      // Get existing items
      List existingItems = HiveService.to.read('shopItems') ?? [];

      // Check if item already exists in the list
      final existingIndex =
          existingItems.indexWhere((item) => item['id'] == itemId);

      if (existingIndex == -1) {
        // Item doesn't exist, add it
        existingItems.add(itemToSave);
      } else {
        // Item exists, update its status
        existingItems[existingIndex]['status'] = 1;
      }

      // Add to background list if it's a background item
      if (itemToSave['kategori'] == 'background') {
        IotController.to.listBackground.add(itemToSave);
      }

      // Save updated list
      HiveService.to.save('shopItems', existingItems);

      Get.dialog(const SuccessDialog());

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
