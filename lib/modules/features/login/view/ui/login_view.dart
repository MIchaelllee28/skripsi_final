import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/modules/features/login/controllers/login_controller.dart';
import 'package:trainee/shared/styles/google_text_style.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/assets/images/auth/backround.png"),
              fit: BoxFit.fill),
        ),
        child: Center(
            child: Container(
          height: 350, // Adjusted height for better fitting
          width: 350, // Adjusted width for better fitting
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color.fromARGB(255, 39, 166, 107).withOpacity(0.5),
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Welcome to TANI',
                    style: GoogleTextStyle.fw200.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 4, 79, 48),
                    ), // Use a custom font if available
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: LoginController.to.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: LoginController.to.passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      LoginController.to.authentication();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D40),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      LoginController.to.topButton.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => TextButton(
                    onPressed: () {
                      LoginController.to.changeText();
                    },
                    child: Text(
                      LoginController.to.bottomButton.value,
                      style: GoogleTextStyle.fw200.copyWith(
                        color: const Color(0xFF004D40),
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
