import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
import 'package:trainee/modules/global_models/sensor_data_model.dart';

import '../../shop/view/components/success_dialog.dart';

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

// Single database reference for all sensor data
  final database = FirebaseDatabase.instance.ref('test');
  late Rx<SensorData> sensorData;

  // audio player
  late AudioPlayer player = AudioPlayer();

  // selected items from hive (settings)

  RxMap selectedItems = {}.obs;
  RxMap iotLogic = {}.obs;
  //pengaturan coin
  RxInt coinValue = 0.obs;
  DateTime? lastWaterStamp;
  RxInt waterCount = 1.obs;

  @override
  void onInit() async {
    super.onInit();

    //init selected items
    selectedItems.value = HiveService.to.selectedBox.get('selectedItems') ?? {};
    iotLogic.value = HiveService.to.iotLogicBox.get('iot_logic') ?? {};
    coinValue.value = iotLogic['coin'];
    waterCount.value = iotLogic['water_count'] ?? 1;
    lastWaterStamp = iotLogic['water_stamp'] != null
        ? DateTime.tryParse(iotLogic['water_stamp'])
        : null;
    getBackgroundColor();
    getPotSkin();

    //init hints
    fetchHints();

    //change index
    changeHintsIndex();

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.loop);

    // Start the player as soon as the app is displayed.
    getMusic();

    //inisialisasi sensor data dengan default value
    sensorData = SensorData(
      soil1: 0,
      soil2: 0,
      soil3: 0,
      temp: 0,
      liquid: true,
      relay1: true,
      relay2: true,
      relay3: true,
    ).obs;

    //listener for all sensor data
    database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;

        sensorData.value = SensorData.fromJson(data);
      }
    });

    listBackground.value = await HiveService.to
            .read('shopItems')
            .where((item) => item['kategori'] == 'background')
            .toList() ??
        [];
    currentIndexBg.value = listBackground.indexWhere(
        (element) => element['nama'] == selectedItems['background']?['name']);
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

  final RxString bgName = 'Calmy Grey'.obs;
  Future<void> getNameBg() async {
    final result = selectedItems['background']['name'];
    bgName.value = result;
  }

  final RxList listBackground = [].obs;
  final RxInt currentIndexBg = 0.obs;
  Future changeIndex(String code) async {
    currentIndexBg.value = code == 'plus'
        ? (currentIndexBg.value + 1) % listBackground.length
        : (currentIndexBg.value - 1) % listBackground.length;
    updateArrow();
  }

  String getLevel() {
    if (waterCount.value <= 6) {
      return 'Lv1';
    } else if (waterCount.value > 6) {
      return 'Lv2';
    } else if (waterCount.value > 13) {
      return 'Lv3';
    } else {
      return '';
    }
  }

  Future updateArrow() async {
    selectedItems['background'] = {
      'id': listBackground[currentIndexBg.value]['id'],
      'name': listBackground[currentIndexBg.value]['nama'],
      'deskripsi': listBackground[currentIndexBg.value]['deskripsi'],
    };

    bgName.value = listBackground[currentIndexBg.value]['nama'];
    final hexColor =
        selectedItems['background']['deskripsi'].replaceAll("#", "");
    r.value = int.parse(hexColor.substring(0, 2), radix: 16);
    g.value = int.parse(hexColor.substring(2, 4), radix: 16);
    b.value = int.parse(hexColor.substring(4, 6), radix: 16);

    await HiveService.to.selectedBox.put('selectedItems', selectedItems);
  }

  //get the pot skin

  RxString potSkinPath = ''.obs;

  Future<void> getPotSkin() async {
    final result = await selectedItems['pot']['deskripsi'];
    potSkinPath.value = result;
  }

  //get the music
  RxString musicPath = ''.obs;

  Future<void> getMusic() async {
    await player.stop();
    final result = await selectedItems['music']['deskripsi'];
    musicPath.value = result;
    await player.play(AssetSource(musicPath.value), volume: 100);
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
    database.update({'relay1': !sensorData.value.relay1});
  }

  void toogleRelay2() {
    database.update({'relay2': !sensorData.value.relay2});
  }

  void toogleRelay3() {
    database.update({'relay3': !sensorData.value.relay3});
    Get.dialog(const SuccessDialog());
  }

// Getter for the relay
  bool get relayValue1 => sensorData.value.relay1;
  bool get relayValue2 => sensorData.value.relay2;
  bool get relayValue3 => sensorData.value.relay3;

// Getter for the soil
  int get soilValue1 => sensorData.value.soil1;
  int get soilValue2 => sensorData.value.soil2;
  int get soilValue3 => sensorData.value.soil3;

// Getter for the temp
  int get tempValue => sensorData.value.temp;

// Getter for the liquid
  bool get liquidValue => sensorData.value.liquid;

  void addCoins(
      {required int amount, DateTime? dateTime, int? waterCount}) async {
    coinValue.value += amount;
    final iotLogicMap = {
      'coin': coinValue.value,
      'water_stamp': dateTime?.toIso8601String() ?? iotLogic['water_stamp'],
      'water_count': waterCount ?? iotLogic['water_count'],
    };
    await HiveService.to.iotLogicBox.put('iot_logic', iotLogicMap);
    lastWaterStamp = dateTime;
    update();
  }

  void reduceCoins(int amount) async {
    coinValue.value -= amount;
    final iotLogicMap = {
      'coin': coinValue.value,
      'water_stamp': iotLogic['water_stamp'],
      'water_count': iotLogic['water_count'],
    };
    await HiveService.to.iotLogicBox.put('iot_logic', iotLogicMap);
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
        final now = DateTime.now();
        if (lastWaterStamp != null && now.isBefore(lastWaterStamp!)) {
          Get.showSnackbar(
            GetSnackBar(
              title: 'Already water the plant',
              message: 'you can only water plant 1 times per day',
              animationDuration: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 2000),
              icon: Icon(
                Icons.info_outline,
                color: Colors.amber.shade800,
                size: 20,
              ),
            ),
          );
          return;
        }

        waterCount.value = waterCount.value + 1;
        lastWaterStamp = DateTime.now();
        IotController.to.addCoins(
          amount: 500,
          dateTime: DateTime(now.year, now.month, now.day + 1),
          waterCount: waterCount.value,
        );
        refresh();

        Get.showSnackbar(
          GetSnackBar(
            title: 'Successfuly water plant',
            message: 'success water the plant, got 200 coin as reward',
            animationDuration: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 2000),
            icon: Icon(
              Icons.monetization_on_rounded,
              color: Colors.green.shade800,
              size: 20,
            ),
          ),
        );
        break;
    }
  }
}
