import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/authentication/controllers/login/login_controller.dart';
import 'package:osmart/features/authentication/validators/auth_validators.dart';
import 'package:osmart/features/authentication/screens/password_configuration/forget_passwrod.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              'Connexion',
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16),
                    Container(
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.login, color: Colors.blue, size: 60),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: controller.email,
                      validator: AuthValidators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.grey[800]),
                      decoration: _inputDecoration('Email'),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        validator: AuthValidators.validatePassword,
                        obscureText: controller.hidePassword.value,
                        style: TextStyle(color: Colors.grey[800]),
                        decoration: _inputDecoration('Mot de passe').copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.hidePassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => controller.hidePassword.toggle(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.to(() => ForgetPasswordScreen()),
                        child: Text(
                          'Mot de passe oublié?',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Bouton Google
                    Obx(
                      () => OutlinedButton.icon(
                        onPressed: controller.isGoogleLoading.value
                            ? null
                            : () => controller.loginWithGoogle(),
                        icon: controller.isGoogleLoading.value
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(Icons.g_mobiledata, size: 24),
                        label: Text('Continuer avec Google'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
            child: Obx(
              () => FilledButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.loginWithEmail(),
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: controller.isLoading.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.blue, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
    );
  }
}
