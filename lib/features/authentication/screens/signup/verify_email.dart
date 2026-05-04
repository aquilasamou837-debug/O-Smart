import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:osmart/features/authentication/screens/login_success/loginsucces.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() => _canResend = true);
        timer.cancel();
      }
    });
  }

  void _verifyCode() {
    setState(() => _isLoading = true);
    // Logique de vérification ici
    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      // Naviguer vers la home si OK
      Get.to(LoginSuccessScreen(username: 'Aquilas',));
    });
  }

  void _resendCode() {
    if (!_canResend) return;
    // Logique pour renvoyer le code
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Code renvoyé à ${widget.email}')));
    _startTimer(); // Relance le timer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      body: Column(
        children: [
          // 1. Element fixe en haut
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              'Vérification',
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
                  SizedBox(height: 16),
                  Container(
                    width: 100,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.mail_outline,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Confirmez votre email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Nous avons envoyé un code à 6 chiffres à',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 24,
                      letterSpacing: 8,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Code de vérification',
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      counterText: '',
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
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous n'avez pas reçu le code? ",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      GestureDetector(
                        onTap: _resendCode,
                        child: Text(
                          _canResend
                              ? 'Renvoyer'
                              : 'Renvoyer dans ${_secondsRemaining}s',
                          style: TextStyle(
                            color: _canResend ? Colors.blue : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. Bouton fixé en bas de page
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: OutlinedButton(
              onPressed: _isLoading ? null : _verifyCode,
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
              child: _isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'CONFIRMER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
