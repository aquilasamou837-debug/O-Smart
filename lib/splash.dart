import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:osmart/features/authentication/controllers/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Lottie.asset(
                'assets/animations/splash.json',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
                repeat: true,
                animate: true,
              ),
            ),
          ),
          // Loading en bas
          Padding(
            padding: EdgeInsets.only(bottom: 60),
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}