import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;
import 'package:osmart/features/authentication/screens/login_success/loginsucces.dart';
import 'package:osmart/features/authentication/models/user_model.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // Form
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  // State
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;
  final hidePassword = true.obs;

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _googleSignIn = GoogleSignIn.instance; // ← Corrigé v6

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  // EMAIL/PASSWORD LOGIN
  Future<void> loginWithEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Update lastLogin dans Firestore
      await _db.collection('users').doc(userCredential.user!.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      developer.log(
        'Login success: ${userCredential.user!.uid}',
        name: 'Login',
      );

      // Récupère username depuis Firestore
      final userDoc = await _db
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      final username = userDoc.data()?['username'] ?? 
                       userCredential.user!.displayName ?? 
                       'User';

      Get.offAll(() => LoginSuccessScreen(username: username));

    } on FirebaseAuthException catch (e) {
      developer.log('FirebaseAuth Error', name: 'Login', error: e);
      Get.snackbar('Erreur', _handleAuthError(e.code));
    } catch (e) {
      developer.log('Erreur login', name: 'Login', error: e);
      Get.snackbar('Erreur', 'Erreur inattendue: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // GOOGLE SIGN-IN
  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;

      // 1. Init + Auth avec le nouveau flow v6
      await _googleSignIn.initialize();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // 2. Récupère les tokens
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // 3. Crée credential Firebase - idToken suffit en v6
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // 4. Sign in Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user!;

      // 5. Crée/Update user dans Firestore
      final userDoc = await _db.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // Premier login Google = crée doc
        final newUser = UserModel(
          uid: user.uid,
          email: user.email!,
          username: user.displayName ?? 'User',
          licenceKey: '', // À demander après si besoin
        );
        await _db.collection('users').doc(user.uid).set(newUser.toJson());
        developer.log('Nouveau user Google créé', name: 'Login');
      } else {
        // Update lastLogin
        await _db.collection('users').doc(user.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
      }

      Get.offAll(
        () => LoginSuccessScreen(username: user.displayName ?? 'User'),
      );

    } on FirebaseAuthException catch (e) {
      developer.log('Google SignIn Error', name: 'Login', error: e);
      Get.snackbar('Erreur', _handleAuthError(e.code));
    } catch (e) {
      developer.log('Erreur Google SignIn', name: 'Login', error: e);
      Get.snackbar('Erreur', 'Connexion Google échouée');
    } finally {
      isGoogleLoading.value = false;
    }
  }

  String _handleAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Aucun compte trouvé avec cet email';
      case 'wrong-password':
        return 'Mot de passe incorrect';
      case 'invalid-email':
        return 'Email invalide';
      case 'user-disabled':
        return 'Ce compte a été désactivé';
      case 'account-exists-with-different-credential':
        return 'Email déjà utilisé avec une autre méthode';
      default:
        return 'Erreur: $code';
    }
  }
}