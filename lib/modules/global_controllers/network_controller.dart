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
            color: Colors.white, // White text color
            fontWeight: FontWeight.bold, // Bold text for emphasis
          ),
        ),
        backgroundColor: Colors.red, // Red background color
        isDismissible: false,
        duration: const Duration(days: 1),
        margin: const EdgeInsets.all(10), // Add margin for better positioning
        borderRadius: 8, // Rounded corners for a smoother look
        snackPosition: SnackPosition.BOTTOM, // Position at the bottom
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
