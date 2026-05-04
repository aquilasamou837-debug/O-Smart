import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token; // Token reçu par email/lien
  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_passwordController.text.isEmpty) {
      _showError('Veuillez entrer un mot de passe');
      return;
    }
    if (_passwordController.text.length < 8) {
      _showError('Le mot de passe doit faire 8 caractères minimum');
      return;
    }
    if (_passwordController.text!= _confirmPasswordController.text) {
      _showError('Les mots de passe ne correspondent pas');
      return;
    }

    setState(() => _isLoading = true);
    // Logique reset avec widget.token
    Future.delayed(Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mot de passe réinitialisé avec succès')),
      );
      // Retour au login
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
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
              'Nouveau mot de passe',
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
                      child: Icon(Icons.lock_open, color: Colors.blue, size: 60),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Créez un nouveau mot de passe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Votre nouveau mot de passe doit être différent de l\'ancien.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  SizedBox(height: 32),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: Colors.grey[800]),
                    decoration: InputDecoration(
                      labelText: 'Nouveau mot de passe',
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      filled: true,
                      fillColor: Colors.blue[50],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: () => setState(() => _obscurePassword =!_obscurePassword),
                      ),
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
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(color: Colors.grey[800]),
                    decoration: InputDecoration(
                      labelText: 'Confirmer le mot de passe',
                      labelStyle: TextStyle(color: Colors.grey[900]),
                      filled: true,
                      fillColor: Colors.blue[50],
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                        ),
                        onPressed: () => setState(() => _obscureConfirmPassword =!_obscureConfirmPassword),
                      ),
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
                    obscureText: _obscurePassword,
                    style: TextStyle(color: Colors.grey[800]),
                    decoration: InputDecoration(
                      labelText: 'Nouveau mot de passe de verification',
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
                  Text(
                    '• 8 caractères minimum\n• 1 majuscule et 1 chiffre recommandés',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          // 3. Bouton fixé en bas de page
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: OutlinedButton(
              onPressed: _isLoading? null : _resetPassword,
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
                      'RÉINITIALISER',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}