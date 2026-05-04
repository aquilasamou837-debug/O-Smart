import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
          repeat: false, // 🔹 l’animation ne boucle pas
          animate: true, // 🔹 lance l’animation
          onLoaded: (composition) {
            // 🔹 une fois l’animation chargée, on attend sa durée avant de naviguer
            Future.delayed(composition.duration, () {
              // 🔹 ici, tu peux naviguer vers la page principale de ton app
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => PrincipaleScreen()));
            });
          },
        ),
      ),
    );
  }
}
