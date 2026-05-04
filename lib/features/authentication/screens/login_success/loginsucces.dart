import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:osmart/my_app.dart';

class LoginSuccessScreen extends StatefulWidget {
  final String username;
  const LoginSuccessScreen({super.key, required this.username});

  @override
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  Timer? _timer;
  int _secondsRemaining = 3;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
        if (mounted) {
          Get.offAll(PrincipaleScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Element fixe en haut
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

          // 2. Contenu scrollable au milieu
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
                    widget.username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Redirection dans $_secondsRemaining s...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
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
