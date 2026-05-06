import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PrincipalController extends GetxController {
  static PrincipalController get instance => Get.find();

  final pageController = PageController();
  final selectedIndex = 0.obs;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}