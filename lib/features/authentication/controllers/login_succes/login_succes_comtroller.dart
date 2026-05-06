import 'package:get/get.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:osmart/features/shop/screens/principal/principal_page.dart'; // Ton PrincipaleScreen

class LoginSuccessController extends GetxController {
  final String username;
  LoginSuccessController({required this.username});

  final secondsRemaining = 3.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    developer.log('Login success pour: $username', name: 'LoginSuccess');
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 1) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
        Get.offAll(() => PrincipaleScreen()); // Ou PrincipaleScreen()
      }
    });
  }

  // Skip le timer si user clique
  void skipToHome() {
    _timer?.cancel();
    Get.offAll(() => PrincipaleScreen());
  }
}
