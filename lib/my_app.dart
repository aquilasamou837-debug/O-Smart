import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'O\'Smart', // ← Au lieu de 'Stylish Bottom Navigation Bar Example'
      theme: ThemeData(
        useMaterial3: true, // ← Décommente pour le nouveau design
        primarySwatch: Colors.blue, // ← Ton app est bleue, pas verte
      ),
      home: const SplashScreen(),
    );
  }
}