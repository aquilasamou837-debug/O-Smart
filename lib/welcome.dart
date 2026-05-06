import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osmart/features/authentication/controllers/welcome/welcome_controller.dart';
import 'package:osmart/features/authentication/screens/login/login.dart';
import 'package:osmart/features/authentication/screens/signup/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WelcomeController());

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(
                    () => OutlinedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.signInWithGoogle(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3C4043),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      icon: controller.isLoading.value
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : SvgPicture.asset(
                              'assets/logo/google_icon.svg',
                              height: 24,
                              width: 24,
                            ),
                      label: Text(
                        controller.isLoading.value
                            ? 'Connexion...'
                            : 'Se connecter avec Google',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: const Text('Se connecter avec Email'),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    child: const Text('Créer un compte'),
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
