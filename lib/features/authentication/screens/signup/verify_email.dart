import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/authentication/controllers/signup/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Vérification',
              style: TextStyle(color: Colors.grey[800], fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Icon(Icons.mail_outline, color: Colors.blue, size: 60)),
                  ),
                  SizedBox(height: 32),
                  Text('Confirmez votre email', style: TextStyle(color: Colors.grey[800], fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Text('Nous avons envoyé un lien à', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  SizedBox(height: 4),
                  Text(email, style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  Text('Clique sur le lien dans l\'email. Cette page se fermera automatiquement.',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 24),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vous n'avez pas reçu l'email? ", style: TextStyle(color: Colors.grey[600])),
                          GestureDetector(
                            onTap: controller.canResend.value ? () => controller.sendEmailVerification() : null,
                            child: Text(
                              controller.canResend.value ? 'Renvoyer' : 'Renvoyer dans ${controller.secondsRemaining}s',
                              style: TextStyle(
                                color: controller.canResend.value ? Colors.blue : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: Obx(() => OutlinedButton(
                  onPressed: controller.isLoading.value ? null : () => controller.manuallyCheckVerification(),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.blue,
                  ),
                  child: controller.isLoading.value
                     ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text('J\'AI CLIQUÉ LE LIEN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                )),
          ),
        ],
      ),
    );
  }
}