import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:osmart/features/authentication/screens/login/login.dart';
import 'package:osmart/my_app.dart';
import 'dart:developer' as developer;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Init obligatoire en v6+
    _initGoogleSignIn();
  }

  Future<void> _initGoogleSignIn() async {
    await GoogleSignIn.instance.initialize(
      clientId:
          '1069046971389-nm7ka9hpjts5nk2tl59n5k19lgqbpa6l.apps.googleusercontent.com',
      serverClientId:
          '1069046971389-nm7ka9hpjts5nk2tl59n5k19lgqbpa6l.apps.googleusercontent.com',
    );
  }

  Future<void> _signInWithGoogle() async {
  developer.log('Clic bouton Google', name: 'Auth'); // ← Ajoute ça
  setState(() => _isLoading = true);

  try {
    developer.log('Lancement authenticate()', name: 'Auth'); // ← Et ça
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
    
    developer.log('User Google récupéré: ${googleUser.email}', name: 'Auth'); // ← Et ça
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    developer.log('Token récupéré, création credential', name: 'Auth'); // ← Et ça
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    developer.log('Appel Firebase signInWithCredential', name: 'Auth'); // ← Et ça
    final UserCredential userCredential = await _auth.signInWithCredential(credential);

    developer.log('=== FIREBASE USER ===', name: 'Auth');
    developer.log('UID: ${userCredential.user?.uid}', name: 'Auth');
    developer.log('Email: ${userCredential.user?.email}', name: 'Auth');
    developer.log('=====================', name: 'Auth');

    Get.offAllNamed('/home');

  } on GoogleSignInException catch (e) {
    developer.log('GoogleSignInException: ${e.code} - ${e.description}', name: 'Auth', error: e);
    if (e.code != GoogleSignInExceptionCode.canceled) {
      Get.snackbar('Erreur', 'Connexion Google échouée: ${e.description}');
    }
  } catch (e, stackTrace) {
    developer.log('Catch général: $e', name: 'Auth', error: e, stackTrace: stackTrace);
    Get.snackbar('Erreur', 'Erreur inattendue: $e');
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
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
                  OutlinedButton.icon(
                    onPressed: _isLoading ? null : _signInWithGoogle,
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
                    icon: _isLoading
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
                      _isLoading ? 'Connexion...' : 'Se connecter avec Google',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Get.to(() => const LoginScreen()),
                    child: const Text('Se connecter avec Email'),
                  ),
                  TextButton(
                    onPressed: () {},
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
