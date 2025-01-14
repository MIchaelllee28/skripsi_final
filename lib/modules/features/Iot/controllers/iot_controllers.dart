import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/home_button.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/settings_button.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/shop_button.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/trophy_button.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/tutorial_button.dart';
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/water_button.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/hive_service.dart';

enum Directions { left, right }

enum Buttons {
  home,
  settings,
  shop,
  trophy,
  tutorial,
  water,
}

class IotController extends GetxController {
  static IotController get to => Get.find();

  // inisialisasi list hints dan timer
  RxList<dynamic> hints = [].obs;
  RxInt hintIndex = 0.obs;
  Timer? timer;

  // pengaturan soil moisture
  final databaseSoil1 = FirebaseDatabase.instance.ref('test/soil1');
  final databaseSoil2 = FirebaseDatabase.instance.ref('test/soil2');
  final databaseSoil3 = FirebaseDatabase.instance.ref('test/soil3');
  final RxInt _soilValue1 = 0.obs;
  final RxInt _soilValue2 = 0.obs;
  final RxInt _soilValue3 = 0.obs;

  // pengaturan light intensity
  final databaseTemp = FirebaseDatabase.instance.ref('test/temp');
  final RxInt _tempValue = 0.obs;

  // pengaturan liquid level
  final databaseLiquid = FirebaseDatabase.instance.ref('test/liquid');
  final RxBool _liquidValue = true.obs;

  // pengaturan relay
  final databaseRelay1 = FirebaseDatabase.instance.ref('test/relay1');
  final databaseRelay2 = FirebaseDatabase.instance.ref('test/relay2');
  final databaseRelay3 = FirebaseDatabase.instance.ref('test/relay3');
  final RxBool _relayValue1 = true.obs;
  final RxBool _relayValue2 = true.obs;
  final RxBool _relayValue3 = true.obs;

  // selected items from hive (settings)

  RxMap selectedItems = {}.obs;

  @override
  void onInit() {
    super.onInit();

    //init selected items
    selectedItems.value = HiveService.to.selectedBox.get('selectedItems') ?? {};
    getBackgroundColor();
    getPotSkin();

    //init hints
    fetchHints();

    //change index
    changeHintsIndex();

    // init soil moisture
    databaseSoil1.onValue.listen((event) {
      _soilValue1.value = event.snapshot.value as int;
    });
    databaseSoil2.onValue.listen((event) {
      _soilValue2.value = event.snapshot.value as int;
    });
    databaseSoil3.onValue.listen((event) {
      _soilValue3.value = event.snapshot.value as int;
    });

    // init temp
    databaseTemp.onValue.listen((event) {
      _tempValue.value = event.snapshot.value as int;
    });

    // init liquid
    databaseLiquid.onValue.listen((event) {
      _liquidValue.value = event.snapshot.value as bool;
    });

    // init relay
    databaseRelay1.onValue.listen((event) {
      _relayValue1.value = event.snapshot.value as bool;
    });
    databaseRelay2.onValue.listen((event) {
      _relayValue2.value = event.snapshot.value as bool;
    });
    databaseRelay3.onValue.listen((event) {
      _relayValue3.value = event.snapshot.value as bool;
    });
  }

  // get the backround color rgb
  final Rx<int> r = 255.obs;
  final Rx<int> g = 255.obs;
  final Rx<int> b = 255.obs;

  Future<void> getBackgroundColor() async {
    final result = selectedItems['background']['deskripsi'];
    final hexColor = result.replaceAll("#", "");
    r.value = int.parse(hexColor.substring(0, 2), radix: 16);
    g.value = int.parse(hexColor.substring(2, 4), radix: 16);
    b.value = int.parse(hexColor.substring(4, 6), radix: 16);
  }

  //get the pot skin

  RxString potSkinPath = ''.obs;

  Future<void> getPotSkin() async {
    final result = await selectedItems['pot']['deskripsi'];
    potSkinPath.value = result;
  }

  //fetch data hints untuk bottom body
  Future<void> fetchHints() async {
    final result = await DioService.dioCall().get('hints');
    hints.value = result.data;
  }

  void changeHintsIndex() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      if (hintIndex.value < 49) {
        hintIndex.value++;
      } else {
        hintIndex.value = 0;
      }
    });
  }

  // metode mengubah relay
  void toogleRelay1() {
    databaseRelay1.set(!_relayValue1.value);
  }

  void toogleRelay2() {
    databaseRelay2.set(!_relayValue2.value);
  }

  void toogleRelay3() {
    databaseRelay3.set(!_relayValue3.value);
  }

  // Getter for the relay
  RxBool get relayValue1 => _relayValue1;
  RxBool get relayValue2 => _relayValue2;
  RxBool get relayValue3 => _relayValue3;

  // Getter for the soil
  RxInt get soilValue1 => _soilValue1;
  RxInt get soilValue2 => _soilValue2;
  RxInt get soilValue3 => _soilValue3;

  // Getter for the light
  RxInt get tempValue => _tempValue;

  // Getter for the liquid
  RxBool get liquidValue => _liquidValue;

  //pengaturan coin
  RxInt coinValue = 250.obs;

  void addCoins(int amount) {
    coinValue.value += amount;
    update();
  }

  // bottomButtonController

  RxInt toogleButton = 0.obs;

  void changeButton(Directions direction) {
    if (toogleButton.value >= 0 && direction == Directions.left) {
      toogleButton.value--;
    } else if (toogleButton.value <= 5 && direction == Directions.right) {
      toogleButton.value++;
    }
  }

  Widget getButtons(int finalButton) {
    int hey = finalButton;
    switch (hey) {
      case 0:
        return const HomeButton();
      case 1:
        return const SettingsButton();
      case 2:
        return const ShopButton();
      case 3:
        return const TrophyButton();
      case 4:
        return const TutorialButton();
      case 5:
        return const WaterButton();
      default:
        return const HomeButton();
    }
  }

  void buttonMove(Buttons button) {
    switch (button) {
      case Buttons.home:
        Get.toNamed(MainRoute.home);
        break;
      case Buttons.settings:
        Get.toNamed(MainRoute.settings);
        break;
      case Buttons.shop:
        Get.toNamed(MainRoute.shop);
        break;
      case Buttons.trophy:
        Get.toNamed(MainRoute.trophy);
        break;
      case Buttons.tutorial:
        Get.toNamed(MainRoute.tutorial);
        break;
      case Buttons.water:
        Get.toNamed(MainRoute.home);
        break;
    }
  }
}
