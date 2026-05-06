import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Form
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  // State
  final isLoading = false.obs;

  final _auth = FirebaseAuth.instance;

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  Future<void> sendPasswordResetEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      await _auth.sendPasswordResetEmail(email: email.text.trim());

      developer.log('Email reset envoyé: ${email.text.trim()}', name: 'ForgetPassword');

      Get.snackbar(
        'Succès',
        'Lien de réinitialisation envoyé à ${email.text.trim()}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      // Retour login après 2s
      await Future.delayed(Duration(seconds: 2));
      Get.back();

    } on FirebaseAuthException catch (e) {
      developer.log('FirebaseAuth Error', name: 'ForgetPassword', error: e);
      Get.snackbar('Erreur', _handleAuthError(e.code));
    } catch (e) {
      developer.log('Erreur reset', name: 'ForgetPassword', error: e);
      Get.snackbar('Erreur', 'Erreur inattendue: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String _handleAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Aucun compte trouvé avec cet email';
      case 'invalid-email':
        return 'Email invalide';
      case 'too-many-requests':
        return 'Trop de tentatives. Réessaie plus tard';
      default:
        return 'Erreur: $code';
    }
  }
}