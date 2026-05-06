import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/authentication/controllers/login_succes/login_succes_comtroller.dart';

class LoginSuccessScreen extends StatelessWidget {
  final String username;
  const LoginSuccessScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginSuccessController(username: username));

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => controller.skipToHome(), // Tap pour skip
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16, 60, 16, 0),
              child: Text(
                'Connexion réussie',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.2),
                            blurRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 80,
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Bienvenue!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Ravi de vous revoir,',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      controller.username,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 32),
                    Obx(
                      () => Text(
                        'Redirection dans ${controller.secondsRemaining}s...',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tape pour continuer',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
