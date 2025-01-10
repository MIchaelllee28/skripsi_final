import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/tutorial/repository/alat_bahan_repository.dart';
import 'package:trainee/modules/features/tutorial/repository/chip_repository.dart';
import 'package:trainee/modules/features/tutorial/repository/icons_repository.dart';
import 'package:trainee/modules/features/tutorial/repository/kangkung_repository.dart';
import 'package:trainee/modules/features/tutorial/repository/sawi_repository.dart';
import 'package:trainee/modules/features/tutorial/repository/selada_repository.dart';
import 'package:trainee/modules/features/tutorial/view/components/content/tutorial_alat.dart';
import 'package:trainee/modules/features/tutorial/view/components/content/tutorial_icon.dart';
import 'package:trainee/modules/features/tutorial/view/components/content/tutorial_menanam_kangkung.dart';
import 'package:trainee/modules/features/tutorial/view/components/content/tutorial_menanam_sawi.dart';
import 'package:trainee/modules/features/tutorial/view/components/content/tutorial_menanam_selada.dart';

class TutorialController extends GetxController {
  static TutorialController get to => Get.find();
  final KangkungRepository _kangkungRepository = Get.put(KangkungRepository());
  final SawiRepository _sawiRepository = Get.put(SawiRepository());
  final SeladaRepository _seladaRepository = Get.put(SeladaRepository());
  final AlatBahanRepository _alatBahanRepository =
      Get.put(AlatBahanRepository());
  final IconsRepository _iconsRepository = Get.put(IconsRepository());
  final ChipRepository _chipRepository = Get.put(ChipRepository());

// global data for repo
  RxList kangkungData = [].obs;
  RxList seladaData = [].obs;
  RxList sawiData = [].obs;
  RxList alatBahanData = [].obs;
  RxList iconsData = [].obs;
  RxList chipData = [].obs;

// global int for indexing

  RxInt sayuranIndex = 1.obs;
  RxInt chipIndex = 1.obs;

// animation controller
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    _fetchSemuaData();
  }

  void _fetchSemuaData() {
    kangkungData.value = _kangkungRepository.getKangkungData();
    sawiData.value = _sawiRepository.getSawiData();
    seladaData.value = _seladaRepository.getSeladaData();
    alatBahanData.value = _alatBahanRepository.getAlatBahanData();
    iconsData.value = _iconsRepository.getIconData();
    chipData.value = _chipRepository.getChipData();
  }

  void changeKangkungIndex(int direction) {
    if (sayuranIndex < 6 && direction == 1) {
      sayuranIndex++;
    } else if (sayuranIndex > 1 && direction == 0) {
      sayuranIndex--;
    }
  }

  void changeChip(int index) {
    chipIndex.value = index + 1;
  }

  Widget getTutorialTanaman() {
    switch (chipIndex.value) {
      case 1:
        return const TutorialMenanamSawi();

      case 2:
        return const TutorialMenanamSelada();

      case 3:
        return const TutorialMenanamKangkung();

      case 4:
        return const TutorialIcon();

      case 5:
        return const TutorialAlat();

      default:
        return const TutorialIcon();
    }
  }
}
