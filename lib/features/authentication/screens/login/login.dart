import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osmart/features/authentication/screens/login_success/loginsucces.dart';
import 'package:osmart/features/authentication/screens/password_configuration/forget_passwrod.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          // 1. Element fixe en haut
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

          // 2. Contenu scrollable au milieu
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
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
                  TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.grey[800]),
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.grey[800]),
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
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
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(ForgetPasswordScreen());
                      },
                      child: Text(
                        'Mot de passe oublié?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Bouton fixé en bas de page
          Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  onPressed: () {
                    Get.to(LoginSuccessScreen(username: 'Aquilas',));
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
