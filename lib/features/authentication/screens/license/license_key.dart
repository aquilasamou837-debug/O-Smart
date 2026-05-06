import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/authentication/controllers/license/license_key_controller.dart'; // ← Chemin corrigé
import 'package:osmart/features/authentication/validators/auth_validators.dart';

class LicenseKeyScreen extends StatelessWidget {
  const LicenseKeyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LicenseController()); // Le nom de classe reste LicenseController

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              'Clé de licence',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: controller.licenseFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(Icons.vpn_key, color: Colors.blue, size: 60),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Activez votre compte',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Entrez la clé de licence fournie avec votre pompe ESP32 pour débloquer toutes les fonctionnalités.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: controller.licenseKey,
                      validator: AuthValidators.validateLicenceKey,
                      textCapitalization: TextCapitalization.characters,
                      decoration: _inputDecoration('Clé de licence'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
            child: Obx(
              () => OutlinedButton(
                onPressed: controller.isLoading.value? null : () => controller.saveLicenseKey(),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: controller.isLoading.value
                  ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'Valider la clé',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => controller.skipForNow(),
                child: Text(
                  'Passer pour l\'instant',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[900]),
      filled: true,
      fillColor: Colors.blue[50],
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.blue, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}