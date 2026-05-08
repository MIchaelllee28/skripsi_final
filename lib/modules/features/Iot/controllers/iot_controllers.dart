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
import 'package:trainee/modules/features/Iot/view/components/bottom_buttons/lucky_wheel_button.dart';
import 'package:trainee/utils/services/dio_service.dart';
import 'package:trainee/utils/services/hive_service.dart';
import 'package:trainee/utils/services/gemini_services.dart';
import 'package:trainee/modules/global_models/sensor_data_model.dart';
import 'package:trainee/modules/global_models/control_data_model.dart';
import 'package:trainee/modules/features/Iot/view/components/ai_loading_dialog.dart';
import 'package:trainee/modules/features/Iot/view/components/ai_suggestion_dialog.dart';
import 'package:trainee/modules/features/Iot/view/components/actuator_dialog.dart';


enum Directions { left, right }

enum Buttons {
  home,
  settings,
  shop,
  trophy,
  tutorial,
  water,
  luckyWheel,
}

class IotController extends GetxController {
  static IotController get to => Get.find();

  // inisialisasi list hints dan timer
  RxList<dynamic> hints = [].obs;
  RxInt hintIndex = 0.obs;
  Timer? timer;

// Single database reference for all sensor data
  final database = FirebaseDatabase.instance.ref('ESP32');

  // Initialize sensorData with default values to prevent LateInitializationError
  Rx<SensorData> sensorData = SensorData(
    sensorT: SensorT(
      hum: 0.0,
      temp: 0.0,
      ec: 0,
      ph: 0.0,
      n: 0,
      p: 0,
      k: 0,
    ),
    sensorA: SensorA(
      tds: 0,
      ph: 0,
    ),
  ).obs;

//control actuator
  // Initialize controlData with default values to prevent LateInitializationError
  Rx<ControlData> controlData = ControlData(
    lampu: 0,
    phdown: 0,
    phup: 0,
    pompa: 0,
  ).obs;

  // audio player
  late AudioPlayer player = AudioPlayer();

  // selected items from hive (settings)

  RxMap selectedItems = {}.obs;
  RxMap iotLogic = {}.obs;
  //pengaturan coin
  RxInt coinValue = 0.obs;
  DateTime? lastWaterStamp;
  RxInt waterCount = 1.obs;

  // AI Suggestions
  Rx<ActuatorSuggestion?> aiSuggestion = Rx<ActuatorSuggestion?>(null);
  RxBool isLoadingAI = false.obs;

  // Debounce timers for actuator updates
  Timer? _lampDebounce;
  Timer? _phDownDebounce;
  Timer? _phUpDebounce;
  Timer? _pumpDebounce;
  Timer? _aiRevertTimer;

  // Reset all actuators to 0 (Instant)
  Future<void> resetAllActuators() async {
    await setLampValue(0);
    await setPhDownValue(0);
    await setPhUpValue(0);
    await setPumpValue(0);

    Get.snackbar(
      'Reset',
      'All actuators set to 0%',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      icon: const Icon(Icons.restart_alt, color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }

  // Gradual reset to avoid sudden hardware power drop (reduces by 20% every 500ms)
  Future<void> gradualResetAllActuators() async {
    bool hasValueGreaterThanZero = true;

    while (hasValueGreaterThanZero) {
      int newLamp = (controlData.value.lampu - 20).clamp(0, 100).toInt();
      int newPhDown = (controlData.value.phdown - 20).clamp(0, 100).toInt();
      int newPhUp = (controlData.value.phup - 20).clamp(0, 100).toInt();
      int newPump = (controlData.value.pompa - 20).clamp(0, 100).toInt();

      // Update local state instantly for UI
      controlData.value = ControlData(
        lampu: newLamp,
        phdown: newPhDown,
        phup: newPhUp,
        pompa: newPump,
      );

      // Update Firebase directly (bypassing the 300ms debounce of normal setters)
      await FirebaseDatabase.instance.ref('AKTUATOR').update({
        'lampu': newLamp,
        'phdown': newPhDown,
        'phup': newPhUp,
        'pompa': newPump,
      });

      if (newLamp == 0 && newPhDown == 0 && newPhUp == 0 && newPump == 0) {
        hasValueGreaterThanZero = false;
      } else {
        // Wait 500ms before taking the next step down
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();

    //init selected items
    selectedItems.value = HiveService.to.selectedBox.get('selectedItems') ?? {};

    // Initialize default settings if not set
    await _initializeDefaultSettings();

    iotLogic.value = HiveService.to.iotLogicBox.get('iot_logic') ?? {};
    coinValue.value = iotLogic['coin'] ?? 0;
    waterCount.value = iotLogic['water_count'] ?? 1;
    lastWaterStamp = iotLogic['water_stamp'] != null
        ? DateTime.tryParse(iotLogic['water_stamp'].toString())
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

    //listener for all sensor data
    print('🚀 [DEBUG] Initializing Firebase Sensor Listener on path: ESP32');
    database.onValue.listen((event) {
      print('DEBUG: ==========================================');
      print('DEBUG: 🔥 FIREBASE SENSOR EVENT RECEIVED');

      if (event.snapshot.exists) {
        final rawValue = event.snapshot.value;
        print('DEBUG: 📦 Snapshot exists: YES');
        print('DEBUG: 📦 Full Raw Value: $rawValue');
        print('DEBUG: 📦 Type of value: ${rawValue.runtimeType}');

        if (rawValue != null) {
          try {
            final data = Map<dynamic, dynamic>.from(rawValue as Map);
            print('DEBUG: 📊 Map casting successful');
            print('DEBUG: 📊 Keys in map: ${data.keys.toList()}');

            sensorData.value = SensorData.fromJson(data);

            print('DEBUG: ✅ SUCCESSFULLY MAPPED TO SENSOR DATA OBJECT');
            print('DEBUG: 🌡️ Temp (Soil): ${sensorData.value.sensorT.temp}');
            print('DEBUG: 💧 Hum (Soil): ${sensorData.value.sensorT.hum}');
          } catch (e, stacktrace) {
            print('DEBUG: ❌ ERROR DURING PARSING: $e');
            print('DEBUG: 📚 STACKTRACE: $stacktrace');
          }
        } else {
          print(
              'DEBUG: ❌ RAW VALUE IS NULL DESPITE SNAPSHOT.EXISTS BEING TRUE');
        }
      } else {
        print('DEBUG: ❌ SNAPSHOT DOES NOT EXIST (PATH IS EMPTY)');
        print('DEBUG: 📍 Path Checked: ${database.path}');
      }
      print('DEBUG: ==========================================');
    });

    //listener for control data
    FirebaseDatabase.instance.ref('AKTUATOR').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        try {
          controlData.value = ControlData.fromJson(data);
        } catch (e) {
          print('❌ CRASH IN ACTUATOR PARSING: $e');
        }
      }
    });

    // Get default backgrounds that user always has access to
    final defaultBackgrounds = [
      {
        "nama": "Calmy Grey",
        "kategori": "background",
        "deskripsi": "#FFFFFF",
        "status": 1,
        "id": "default_1"
      },
    ];

    // Get purchased backgrounds from shop
    final purchasedBackgrounds = HiveService.to
            .read('shopItems')
            ?.where((item) => item['kategori'] == 'background')
            .toList() ??
        [];

    // Merge default and purchased backgrounds
    listBackground.value = [...defaultBackgrounds, ...purchasedBackgrounds];

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

  // Initialize default settings if they don't exist
  Future<void> _initializeDefaultSettings() async {
    bool needsSave = false;

    // Default background
    if (selectedItems['background'] == null) {
      selectedItems['background'] = {
        'id': 'default_1',
        'name': 'Calmy Grey',
        'deskripsi': '#FFFFFF',
      };
      needsSave = true;
    }

    // Default pot
    if (selectedItems['pot'] == null) {
      selectedItems['pot'] = {
        'id': 'default_pot',
        'name': 'Default Pot',
        'deskripsi': 'assets/images/iot/main_part/pot_basic.png',
      };
      needsSave = true;
      print('🔧 Initialized default pot: ${selectedItems['pot']}');
    }

    // Default music
    if (selectedItems['music'] == null) {
      selectedItems['music'] = {
        'id': 'default_music',
        'name': 'Star Reaction',
        'deskripsi': 'music/star_reaction.mp3',
      };
      needsSave = true;
    }

    // Save defaults if any were set
    if (needsSave) {
      await HiveService.to.selectedBox.put('selectedItems', selectedItems);
      print('💾 Saved default settings to Hive');
    }
  }

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
    try {
      final result = selectedItems['pot']?['deskripsi'];
      if (result != null && result.isNotEmpty) {
        potSkinPath.value = result;
        print('🎨 Pot skin loaded: $result');
      } else {
        potSkinPath.value = 'assets/images/iot/main_part/pot_basic.png';
        print('⚠️ No pot skin found, using default');
      }
    } catch (e) {
      print('❌ Error loading pot skin: $e');
      potSkinPath.value = 'assets/images/iot/main_part/pot_basic.png';
    }
  }

  //get the music
  RxString musicPath = ''.obs;

  Future<void> getMusic() async {
    try {
      await player.stop();
      final result = selectedItems['music']?['deskripsi'];
      if (result != null && result.isNotEmpty) {
        musicPath.value = result;
        await player.play(AssetSource(musicPath.value), volume: 100);
        print('🎵 Music playing: $result');
      } else {
        print('⚠️ No music selected');
      }
    } catch (e) {
      print('❌ Error playing music: $e');
    }
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

//TODO : add proper function
// // metode mengubah relay
//   void toogleRelay1() {
//     database.update({'relay1': !sensorData.value.relay1});
//   }

//   void toogleRelay2() {
//     database.update({'relay2': !sensorData.value.relay2});
//   }

//   void toogleRelay3() {
//     database.update({'relay3': !sensorData.value.relay3});
//     Get.dialog(const SuccessDialog());
//   }

// Set specific values (0 to 100) with debounce
  Future<void> setLampValue(int value) async {
    final clampedValue = value.clamp(0, 100);

    // Cancel previous timer
    _lampDebounce?.cancel();

    // Update local state immediately for UI responsiveness
    controlData.value = ControlData(
      lampu: clampedValue,
      phdown: controlData.value.phdown,
      phup: controlData.value.phup,
      pompa: controlData.value.pompa,
    );

    // Wait 300ms before sending to Firebase
    _lampDebounce = Timer(const Duration(milliseconds: 300), () async {
      print('🔦 Setting Lamp to: $clampedValue');
      await FirebaseDatabase.instance
          .ref('AKTUATOR')
          .update({'lampu': clampedValue});
    });
  }

  Future<void> setPhDownValue(int value) async {
    final clampedValue = value.clamp(0, 100);

    _phDownDebounce?.cancel();

    controlData.value = ControlData(
      lampu: controlData.value.lampu,
      phdown: clampedValue,
      phup: controlData.value.phup,
      pompa: controlData.value.pompa,
    );

    _phDownDebounce = Timer(const Duration(milliseconds: 300), () async {
      print('🔻 Setting pH Down to: $clampedValue');
      await FirebaseDatabase.instance
          .ref('AKTUATOR')
          .update({'phdown': clampedValue});
    });
  }

  Future<void> setPhUpValue(int value) async {
    final clampedValue = value.clamp(0, 100);

    _phUpDebounce?.cancel();

    controlData.value = ControlData(
      lampu: controlData.value.lampu,
      phdown: controlData.value.phdown,
      phup: clampedValue,
      pompa: controlData.value.pompa,
    );

    _phUpDebounce = Timer(const Duration(milliseconds: 300), () async {
      print('🔺 Setting pH Up to: $clampedValue');
      await FirebaseDatabase.instance
          .ref('AKTUATOR')
          .update({'phup': clampedValue});
    });
  }

  Future<void> setPumpValue(int value) async {
    final clampedValue = value.clamp(0, 100);

    _pumpDebounce?.cancel();

    controlData.value = ControlData(
      lampu: controlData.value.lampu,
      phdown: controlData.value.phdown,
      phup: controlData.value.phup,
      pompa: clampedValue,
    );

    _pumpDebounce = Timer(const Duration(milliseconds: 300), () async {
      print('💧 Setting Pump to: $clampedValue');
      await FirebaseDatabase.instance
          .ref('AKTUATOR')
          .update({'pompa': clampedValue});
    });
  }

  // Getters for control states
  int get lampState => controlData.value.lampu;
  int get phDownState => controlData.value.phdown;
  int get phUpState => controlData.value.phup;
  int get pumpState => controlData.value.pompa;

// Getter for soil sensor (sensorT)
  double get soilHumidity => sensorData.value.sensorT.hum;
  double get soilTemp => sensorData.value.sensorT.temp;
  int get soilEC => sensorData.value.sensorT.ec;
  double get soilPH => sensorData.value.sensorT.ph;
  int get soilN => sensorData.value.sensorT.n;
  int get soilP => sensorData.value.sensorT.p;
  int get soilK => sensorData.value.sensorT.k;

// Getter for water sensor (sensorA)
  int get waterTDS => sensorData.value.sensorA.tds;
  double get waterPH => sensorData.value.sensorA.ph;

// Keep old getters for backward compatibility (temporary)
  int get soilValue1 => soilHumidity.toInt();
  int get tempValue => soilTemp.toInt();
  bool get liquidValue => waterTDS > 0;

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
    } else if (toogleButton.value <= 6 && direction == Directions.right) {
      toogleButton.value++;
    }
  }

  //monitoring logic for the pump
  Timer? pumpTimer;

  void startPumpMonitoring() {
    // Cancel any existing timer
    pumpTimer?.cancel();

    // Start monitoring pump value
    pumpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (controlData.value.pompa > 0) {
        // Pump is running, start 10-second countdown
        timer.cancel();
        startWaterCountdown();
      }
    });
  }

  void startWaterCountdown() {
    Timer(Duration(seconds: 10), () {
      if (controlData.value.pompa > 0) {
        // Pump still running after 10 seconds, trigger water logic
        buttonMove(Buttons.water);
        Get.back(); // Close the dialog
      }
    });
  }

  @override
  void onClose() {
    pumpTimer?.cancel();
    _aiRevertTimer?.cancel();
    super.onClose();
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
      case 6:
        return const LuckyWheelButton();
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
      case Buttons.luckyWheel:
        Get.toNamed(MainRoute.luckyWheel);
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

  // AI Suggestion Methods
  Future<void> getAISuggestions() async {
    try {
      isLoadingAI.value = true;

      // Show loading dialog
      Get.dialog(
        const AILoadingDialog(),
        barrierDismissible: false,
      );

      // Test API key first
      print('🔍 Testing API key...');
      await GeminiService.testApiKey();

      final suggestion = await GeminiService.getActuatorSuggestions(
        soilHumidity: soilHumidity,
        soilPH: soilPH,
        waterTDS: waterTDS,
        waterPH: waterPH,
      );

      // Close loading dialog
      Get.back();

      if (suggestion != null) {
        aiSuggestion.value = suggestion;
        Get.dialog(const AISuggestionDialog());
      } else {
        Get.snackbar(
          'Error',
          'Failed to get AI suggestions. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Close loading dialog if still open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print('Error getting AI suggestions: $e');
      Get.snackbar(
        'Error',
        'Something went wrong: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingAI.value = false;
    }
  }

  Future<void> applyAISuggestion(ActuatorSuggestion suggestion) async {
    // await setLampValue(suggestion.lampu);
    await setPhDownValue(suggestion.phdown);
    await setPhUpValue(suggestion.phup);
    await setPumpValue(suggestion.pompa);

    Get.back(); // Close AI suggestion dialog

    // Cancel old timer if exists
    _aiRevertTimer?.cancel();

    // Show success message
    Get.snackbar(
      'Applied',
      'AI suggestions applied. Running for ${suggestion.durationSeconds} seconds.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      duration: const Duration(seconds: 3),
    );

    // Set timer to revert actuators
    if (suggestion.durationSeconds > 0) {
      _aiRevertTimer =
          Timer(Duration(seconds: suggestion.durationSeconds), () async {
        await gradualResetAllActuators();

        // Show reset completed message if needed
        Get.snackbar(
          'AI Process Finished',
          'Actuators have been gradually reset to 0.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
          icon: const Icon(Icons.info, color: Colors.white),
          duration: const Duration(seconds: 2),
        );
      });
    }

    // Reopen actuator dialog after a short delay
    await Future.delayed(const Duration(milliseconds: 300));
    Get.dialog(const ActuatorControlDialog());
  }
}
