import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:trainee/constants/cores/api/api_constant.dart';

class NetworkController extends GetxController {
  static NetworkController get to => Get.find();
  final baseUrl = ApiConstant.production;

  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        messageText: const Text(
          'Connect to the internet',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
        isDismissible: false,
        duration: const Duration(days: 1),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
