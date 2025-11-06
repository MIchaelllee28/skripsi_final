import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/trophy/repository/trophy_chip_repository.dart';
import 'package:trainee/modules/features/trophy/repository/trophy_sayuran_repository.dart';
import 'package:trainee/utils/services/hive_service.dart';

class TrophyController extends GetxController {
  static TrophyController get to => Get.find();

  // inisialisasi repo
  final TrophySayuranRepository trophySayuranRepository =
      Get.put(TrophySayuranRepository());

  final TrophyChipRepository trophyChipRepository =
      Get.put(TrophyChipRepository());

  //isisialisasi data
  RxList trophySayuranData = [].obs;
  RxList trophyChipData = [].obs;
  RxInt trophyIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchSemuaData();
  }

  void _fetchSemuaData() {
    trophyChipData.value = trophyChipRepository.getTrophyChipData();
    trophySayuranData.value = trophySayuranRepository.getTrophySayuranData();
  }

  void changeTrophyIndex(int index) {
    trophyIndex.value = index;
  }

  void claimTrophy(int id) {
    final data = HiveService.to.iotLogicBox.get('iot_logic');
    final dataMap =
        trophySayuranRepository.claimTrophy(id, data['water_count'] ?? 1);

    trophySayuranData.value = dataMap['data'];
    if (!dataMap['success']) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Cannot claim the reward',
          message:
              'you level to low to claim this reward, try again later after level up',
          animationDuration: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 2000),
          icon: Icon(
            Icons.info_outline,
            color: Colors.amber.shade800,
            size: 20,
          ),
        ),
      );
    }
    refresh();
  }

  List getTrophy() {
    switch (trophyIndex.value) {
      case 0:
        return trophySayuranData
            .where((chip) => chip['kategori'] == 'sawi')
            .toList();
      case 1:
        return trophySayuranData
            .where((chip) => chip['kategori'] == 'selada')
            .toList();
      case 2:
        return trophySayuranData
            .where((chip) => chip['kategori'] == 'kangkung')
            .toList();
      default:
        return trophyChipData;
    }
  }
}
