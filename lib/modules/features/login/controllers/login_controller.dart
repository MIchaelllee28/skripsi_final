import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    super.onClose();
  }

  RxString topButton = 'Login'.obs;
  RxString bottomButton = 'SignUp'.obs;
  bool login = true;

  void changeText() {
    login = !login;

    if (login == true) {
      topButton.value = 'Login';
      bottomButton.value = 'SignUp';
    } else {
      topButton.value = 'SignUp';
      bottomButton.value = 'Login';
    }
  }

  Future<void> authentication() async {
    try {
      if (login == true) {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        // Show success snackbar for login
        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        // Show success snackbar for account creation
        Get.snackbar(
          'Success',
          'Account successfully created!',
          backgroundColor: Colors.lightGreen,
          colorText: Colors.white,
        );
      }

      // Navigate to the home screen
      Get.offAllNamed(MainRoute.home);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'No user found for that email.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Wrong password provided.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          e.message ?? 'An error occurred.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
