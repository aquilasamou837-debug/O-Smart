import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'package:osmart/welcome.dart';
import 'package:osmart/features/shop/screens/principal/principal_page.dart'; // Ton PrincipaleScreen

class SplashController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    developer.log('Check auth status...', name: 'Splash');

    // Délai mini 2.5s pour voir le Lottie
    await Future.delayed(Duration(milliseconds: 2500));

    final user = _auth.currentUser;

    if (user == null) {
      developer.log('User non connecté', name: 'Splash');
      Get.offAll(() => const WelcomeScreen());
      return;
    }

    developer.log('User connecté: ${user.uid}', name: 'Splash');

    try {
      // Check email vérifié pour compte email/password
      if (!user.emailVerified && user.providerData.first.providerId == 'password') {
        developer.log('Email non vérifié, déconnexion', name: 'Splash');
        await _auth.signOut();
        Get.offAll(() => const WelcomeScreen());
        Get.snackbar('Email non vérifié', 'Vérifie ton email pour te connecter');
        return;
      }

      // Update lastLogin
      await _db.collection('users').doc(user.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      // Direct page principale
      Get.offAll(() => PrincipaleScreen());

    } catch (e) {
      developer.log('Erreur: $e', name: 'Splash', error: e);
      await _auth.signOut();
      Get.offAll(() => const WelcomeScreen());
    }
  }
}