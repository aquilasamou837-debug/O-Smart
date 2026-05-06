import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/authentication/controllers/signup/signup_controller.dart';
import 'package:osmart/features/authentication/validators/auth_validators.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              'Inscription',
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
                      decoration: _inputDecoration('Email'),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: controller.username,
                      validator: AuthValidators.validateUsername,
                      decoration: _inputDecoration('Nom d\'utilisateur'),
                    ),
                    SizedBox(height: 16),
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        validator: AuthValidators.validatePassword,
                        obscureText: controller.hidePassword.value,
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
                    Obx(
                      () => TextFormField(
                        controller: controller.confirmPassword,
                        validator: (val) =>
                            AuthValidators.validateConfirmPassword(
                              val,
                              controller.password.text,
                            ),
                        obscureText: controller.hideConfirmPassword.value,
                        decoration: _inputDecoration('Confirmer mot de passe')
                            .copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.hideConfirmPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    controller.hideConfirmPassword.toggle(),
                              ),
                            ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: controller.licenceKey,
                      validator: AuthValidators.validateLicenceKey,
                      decoration: _inputDecoration('Clé de licence'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: Obx(
              () => OutlinedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.signup(),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.blue,
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'S\'inscrire',
                        style: TextStyle(color: Colors.white),
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
