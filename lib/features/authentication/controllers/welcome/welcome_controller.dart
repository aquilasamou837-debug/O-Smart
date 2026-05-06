import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'package:osmart/features/authentication/screens/login_success/loginsucces.dart';
import 'package:osmart/features/authentication/models/user_model.dart';

class WelcomeController extends GetxController {
  static WelcomeController get instance => Get.find();

  final isLoading = false.obs;

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _initGoogleSignIn();
  }

  Future<void> _initGoogleSignIn() async {
    await GoogleSignIn.instance.initialize(
      serverClientId:
          '1069046971389-mla9hio5btdu00kgqee5ngg898j2hn45.apps.googleusercontent.com',
    );
    developer.log('GoogleSignIn initialisé', name: 'Welcome');
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      developer.log('Clic bouton Google', name: 'Welcome');
      await GoogleSignIn.instance.signOut();
      // 1. Auth Google
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();
      developer.log(
        'User Google récupéré: ${googleUser.email}',
        name: 'Welcome',
      );

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      developer.log('Token récupéré', name: 'Welcome');

      // 2. Credential Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 3. Sign in Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final user = userCredential.user!;

      developer.log('=== FIREBASE USER ===', name: 'Welcome');
      developer.log('UID: ${user.uid}', name: 'Welcome');
      developer.log('Email: ${user.email}', name: 'Welcome');
      developer.log('=====================', name: 'Welcome');

      // 4. Crée/Update user dans Firestore
      await _createOrUpdateUserInFirestore(user);

      // 5. Redirect
      Get.offAll(
        () => LoginSuccessScreen(username: user.displayName ?? 'User'),
      );
    } on GoogleSignInException catch (e) {
      developer.log(
        'GoogleSignInException: ${e.code} - ${e.description}',
        name: 'Welcome',
        error: e,
      );
      if (e.code != GoogleSignInExceptionCode.canceled) {
        Get.snackbar('Erreur', 'Connexion Google échouée: ${e.description}');
      }
    } catch (e, stackTrace) {
      developer.log(
        'Catch général: $e',
        name: 'Welcome',
        error: e,
        stackTrace: stackTrace,
      );
      Get.snackbar('Erreur', 'Erreur inattendue: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createOrUpdateUserInFirestore(User user) async {
    final userDoc = await _db.collection('users').doc(user.uid).get();

    if (!userDoc.exists) {
      // Premier login = crée le doc
      final newUser = UserModel(
        uid: user.uid,
        email: user.email!,
        username: user.displayName ?? 'User',
        licenceKey: '', // Vide par défaut, à demander après si besoin
        role: 'operateur',
      );
      await _db.collection('users').doc(user.uid).set(newUser.toJson());
      developer.log('Nouveau user créé dans Firestore', name: 'Welcome');
    } else {
      // Update lastLogin
      await _db.collection('users').doc(user.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });
      developer.log('User existant, lastLogin update', name: 'Welcome');
    }
  }
}
