import 'package:get/get.dart';
import 'package:osmart/features/shop/screens/mes_appareils/mes_appareils.dart';
import 'package:osmart/features/shop/screens/notification/notification.dart';
import 'package:osmart/features/authentication/screens/login/login.dart';
import 'package:osmart/features/authentication/screens/signup/signup.dart';
import 'package:osmart/features/authentication/screens/signup/verify_email.dart';
import 'package:osmart/features/authentication/screens/password_configuration/forget_passwrod.dart';
import 'package:osmart/splash.dart';
import 'package:osmart/features/shop/screens/principal/principal_page.dart';
import 'package:osmart/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: ORoutes.splash, page: () => const SplashScreen()),
    GetPage(name: ORoutes.principale, page: () => const PrincipaleScreen()),
    GetPage(name: ORoutes.mesAppareils, page: () => const MesAppareilsScreen()),
    GetPage(name: ORoutes.notification, page: () => const NotificationScreen()),
    
    // Auth
    GetPage(name: ORoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: ORoutes.signup, page: () => const SignUpScreen()),
    GetPage(
      name: ORoutes.verifyEmail, 
      page: () => VerifyEmailScreen(email: Get.arguments['email']),
    ),
    GetPage(name: ORoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
  ];
}