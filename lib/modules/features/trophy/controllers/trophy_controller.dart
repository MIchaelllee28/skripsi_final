import 'package:get/get.dart';
import 'package:trainee/modules/features/Iot/controllers/iot_controllers.dart';
import 'package:trainee/modules/features/trophy/repository/trophy_chip_repository.dart';
import 'package:trainee/modules/features/trophy/repository/trophy_sayuran_repository.dart';

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
    trophySayuranData.value = trophySayuranData.map((item) {
      if (item['id'] == id) {
        if (item['status'] != 1) {
          IotController.to.addCoins(500);
          return {...item, 'status': 1};
        }
      }
      return item;
    }).toList();
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
