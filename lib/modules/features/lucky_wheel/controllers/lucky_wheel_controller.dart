import 'dart:math';
import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/lucky_wheel/models/wheel_prize_model.dart';
import 'package:trainee/utils/services/hive_service.dart';

class LuckyWheelController extends GetxController {
  static LuckyWheelController get to => Get.find();

  final RxBool isSpinning = false.obs;
  final RxDouble rotation = 0.0.obs;
  final Rx<WheelPrize?> selectedPrize = Rx<WheelPrize?>(null);

  DateTime? lastSpinDate;

  final List<WheelPrize> prizes = [
    WheelPrize(id: '1', name: '50 Coins', value: 50, type: 'coin'),
    WheelPrize(id: '2', name: '100 Coins', value: 100, type: 'coin'),
    WheelPrize(id: '3', name: '200 Coins', value: 200, type: 'coin'),
    WheelPrize(id: '4', name: '500 Coins', value: 500, type: 'coin'),
    WheelPrize(id: '5', name: '1000 Coins', value: 1000, type: 'coin'),
    WheelPrize(id: '6', name: 'Better Luck', value: 0, type: 'coin'),
  ];

  @override
  void onInit() {
    super.onInit();
    loadLastSpinDate();
  }

  void loadLastSpinDate() {
    final spinData = HiveService.to.read('lucky_wheel');
    if (spinData != null && spinData['last_spin'] != null) {
      lastSpinDate = DateTime.tryParse(spinData['last_spin']);
    }
  }

  bool canSpin() {
    if (lastSpinDate == null) return true;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastSpin = DateTime(
      lastSpinDate!.year,
      lastSpinDate!.month,
      lastSpinDate!.day,
    );

    return today.isAfter(lastSpin);
  }

  Future<void> spin() async {
    if (!canSpin() || isSpinning.value) return;

    isSpinning.value = true;

    // Random prize selection with weighted probability
    final random = Random();
    final prizeIndex = _getWeightedRandomPrize(random);
    selectedPrize.value = prizes[prizeIndex];

    // Calculate rotation (multiple full spins + final position)
    final fullSpins = 5 + random.nextInt(3); // 5-7 full rotations
    final sectionAngle = 360 / prizes.length;
    final targetAngle =
        (prizes.length - prizeIndex) * sectionAngle - (sectionAngle / 2);
    final totalRotation = (fullSpins * 360) + targetAngle;

    rotation.value = totalRotation;

    // Wait for animation to complete
    await Future.delayed(const Duration(seconds: 4));

    // Award prize
    _awardPrize(selectedPrize.value!);

    // Save spin date
    final now = DateTime.now();
    lastSpinDate = now;
    await HiveService.to.save('lucky_wheel', {
      'last_spin': now.toIso8601String(),
    });

    isSpinning.value = false;
  }

  int _getWeightedRandomPrize(Random random) {
    // Weighted probabilities: lower rewards more common
    final weights = [30, 25, 20, 15, 5, 5]; // Total: 100
    final totalWeight = weights.reduce((a, b) => a + b);
    final randomValue = random.nextInt(totalWeight);

    int cumulativeWeight = 0;
    for (int i = 0; i < weights.length; i++) {
      cumulativeWeight += weights[i];
      if (randomValue < cumulativeWeight) {
        return i;
      }
    }
    return 0;
  }

  void _awardPrize(WheelPrize prize) {
    switch (prize.type) {
      case 'coin':
        if (prize.value > 0) {
          IotController.to.addCoins(amount: prize.value);
        }
        break;
      case 'item':
        // Handle item rewards if needed
        break;
      case 'multiplier':
        // Handle multiplier rewards if needed
        break;
    }
  }

  void reset() {
    rotation.value = 0.0;
    selectedPrize.value = null;
  }
}
