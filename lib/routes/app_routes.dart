import 'package:get/get.dart';
import 'package:osmart/features/shop/screens/command/command.dart';
import 'package:osmart/features/shop/screens/home/home.dart';
import 'package:osmart/features/shop/screens/mes_appareils/mes_appareils.dart';
import 'package:osmart/features/shop/screens/notification/notification.dart';
import 'package:osmart/features/authentication/screens/login/login.dart';
import 'package:osmart/features/authentication/screens/signup/signup.dart';
import 'package:osmart/features/authentication/screens/signup/verify_email.dart';
import 'package:osmart/features/authentication/screens/password_configuration/forget_passwrod.dart';
import 'package:osmart/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:osmart/features/shop/screens/profile/profile.dart';
import 'package:osmart/splash.dart';
import 'package:osmart/my_app.dart';
import 'package:osmart/routes/routes.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: ORoutes.splash, page: () => const SplashScreen()),
    GetPage(name: ORoutes.principale, page: () => const PrincipaleScreen()),
    GetPage(name: ORoutes.home, page: () => const MyHomeScreen()),
    GetPage(name: ORoutes.command, page: () => const CommandScreen()),
    GetPage(name: ORoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: ORoutes.mesAppareils, page: () => const MesAppareilsScreen()),
    GetPage(name: ORoutes.notification, page: () => const NotificationScreen()),
    //GetPage(name: ORoutes.store, page: () => const StoreScreen(),),
    GetPage(name: ORoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: ORoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: ORoutes.verifyEmail, page: () => const VerifyEmailScreen(email: 'user@example.com')),
    GetPage(name: ORoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: ORoutes.resetPassword, page: () => const ResetPasswordScreen(token: '47659',)),
    // add more as needed
  ];
}
