import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'package:osmart/features/authentication/models/user_model.dart';
import 'package:osmart/features/authentication/screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Form
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final licenceKey = TextEditingController();

  // State
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  @override
  void onClose() {
    email.dispose();
    username.dispose();
    password.dispose();
    confirmPassword.dispose();
    licenceKey.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      // 1. Créer user Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // 2. Créer doc Firestore
      final newUser = UserModel(
        uid: userCredential.user!.uid,
        email: email.text.trim(),
        username: username.text.trim(),
        licenceKey: licenceKey.text.trim(),
      );

      await _db
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      developer.log('User créé: ${userCredential.user!.uid}', name: 'Signup');

      // 3. Envoyer email vérification
      await userCredential.user!.sendEmailVerification();

      // 4. Redirection
      Get.offAll(() => VerifyEmailScreen(email: email.text.trim()));
      Get.snackbar('Succès', 'Compte créé. Vérifie tes emails');
    } on FirebaseAuthException catch (e) {
      developer.log('FirebaseAuth Error', name: 'Signup', error: e);
      Get.snackbar('Erreur', _handleAuthError(e.code));
    } catch (e) {
      developer.log('Erreur signup', name: 'Signup', error: e);
      Get.snackbar('Erreur', 'Erreur inattendue: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String _handleAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Cet email est déjà utilisé';
      case 'weak-password':
        return 'Mot de passe trop faible';
      case 'invalid-email':
        return 'Email invalide';
      default:
        return 'Erreur: $code';
    }
  }
}
