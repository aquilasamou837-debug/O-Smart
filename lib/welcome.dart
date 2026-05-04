import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/authentication/screens/login/login.dart';
import 'package:osmart/features/authentication/screens/signup/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Text(
              "Bienvenue sur O'Smart",
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    style: FilledButton.styleFrom(
                      alignment: Alignment.center,
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(color: Colors.blue),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Get.to(SignUpScreen());
                    },
                    style: OutlinedButton.styleFrom(
                      alignment: Alignment.center,
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'S\'inscrire',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
