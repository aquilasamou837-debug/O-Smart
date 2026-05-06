import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osmart/routes/routes.dart';
import 'dart:developer' as developer;

class LicenseController extends GetxController {
  static LicenseController get instance => Get.find();

  // Form
  final licenseKey = TextEditingController();
  final licenseFormKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> saveLicenseKey() async {
    if (!licenseFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final uid = _auth.currentUser?.uid;
      
      if (uid == null) {
        Get.snackbar('Erreur', 'Utilisateur non connecté');
        return;
      }

      final key = licenseKey.text.trim().toUpperCase();
      final licenseRef = _db.collection('licenses').doc(key);

      // 1. Vérifie si la clé existe
      final licenseDoc = await licenseRef.get();
      
      if (!licenseDoc.exists) {
        Get.snackbar(
          'Clé invalide',
          'Cette clé de licence n\'existe pas',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // 2. Vérifie si déjà utilisée
      final licenseData = licenseDoc.data()!;
      if (licenseData['used'] == true) {
        Get.snackbar(
          'Clé déjà utilisée',
          'Cette clé a déjà été activée',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // 3. Transaction atomique : update user + marque clé used
      await _db.runTransaction((transaction) async {
        // Update user
        transaction.update(_db.collection('users').doc(uid), {
          'licenceKey': key,
          'role': licenseData['role'] ?? 'operateur',
          'deviceId': licenseData['deviceId'],
          'licenseActivatedAt': FieldValue.serverTimestamp(),
        });

        // Marque la clé comme utilisée
        transaction.update(licenseRef, {
          'used': true,
          'usedBy': uid,
          'usedAt': FieldValue.serverTimestamp(),
        });
      });

      developer.log('Licence $key activée pour $uid', name: 'License');

      Get.snackbar(
        'Succès',
        'Licence activée avec succès',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Redirect vers page principale
      Get.offAllNamed(ORoutes.principale);

    } on FirebaseException catch (e) {
      developer.log('Erreur Firebase', name: 'License', error: e);
      Get.snackbar(
        'Erreur',
        'Impossible d\'activer la licence: ${e.message}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      developer.log('Erreur inconnue', name: 'License', error: e);
      Get.snackbar('Erreur', 'Une erreur est survenue');
    } finally {
      isLoading.value = false;
    }
  }

  void skipForNow() {
    Get.offAllNamed(ORoutes.principale);
  }

  @override
  void onClose() {
    licenseKey.dispose();
    super.onClose();
  }
}