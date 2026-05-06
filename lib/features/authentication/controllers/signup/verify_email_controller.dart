import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:osmart/features/authentication/screens/login_success/loginsucces.dart';
 // Ta page home

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final isLoading = false.obs;
  final canResend = false.obs;
  final secondsRemaining = 60.obs;
  Timer? _timer;
  Timer? _checkEmailTimer;

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    startResendTimer();
    checkEmailVerifiedPeriodically();
    sendEmailVerification(); // Envoie au démarrage
  }

  @override
  void onClose() {
    _timer?.cancel();
    _checkEmailTimer?.cancel();
    super.onClose();
  }

  void startResendTimer() {
    canResend.value = false;
    secondsRemaining.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // Check auto toutes les 3s si l'user a cliqué le lien
  void checkEmailVerifiedPeriodically() {
    _checkEmailTimer = Timer.periodic(Duration(seconds: 3), (timer) async {
      await _auth.currentUser?.reload();
      if (_auth.currentUser?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(() => LoginSuccessScreen(username: 'Aquilas',)); // Ou LoginSuccessScreen
        Get.snackbar('Succès', 'Email vérifié');
      }
    });
  }

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      developer.log('Email de vérif envoyé', name: 'VerifyEmail');
      Get.snackbar('Envoyé', 'Lien de vérification envoyé');
      startResendTimer();
    } catch (e) {
      developer.log('Erreur envoi email', name: 'VerifyEmail', error: e);
      Get.snackbar('Erreur', 'Impossible d\'envoyer l\'email');
    }
  }

  Future<void> manuallyCheckVerification() async {
    try {
      isLoading.value = true;
      await _auth.currentUser?.reload();
      final user = _auth.currentUser;

      if (user?.emailVerified ?? false) {
        Get.offAll(() => LoginSuccessScreen(username: 'Aquilas',));
        Get.snackbar('Succès', 'Email vérifié');
      } else {
        Get.snackbar('En attente', 'Clique sur le lien dans tes emails');
      }
    } catch (e) {
      developer.log('Erreur check', name: 'VerifyEmail', error: e);
      Get.snackbar('Erreur', 'Impossible de vérifier');
    } finally {
      isLoading.value = false;
    }
  }
}