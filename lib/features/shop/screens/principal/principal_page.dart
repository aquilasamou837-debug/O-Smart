import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:osmart/features/shop/controllers/principal/principal_controller.dart';
import 'package:osmart/features/shop/screens/command/command.dart';
import 'package:osmart/features/shop/screens/home/home.dart';
import 'package:osmart/features/shop/screens/profile/profile.dart';

class PrincipaleScreen extends StatelessWidget {
  const PrincipaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrincipalController());

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) => controller.selectedIndex.value = index,
        children: const [MyHomeScreen(), CommandScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: Obx(
        () => StylishBottomBar(
          option: BubbleBarOptions(
            barStyle: BubbleBarStyle.horizontal,
            bubbleFillStyle: BubbleFillStyle.fill,
            opacity: 0.3,
          ),
          iconSpace: 12.0,
          items: [
            BottomBarItem(
              icon: const Icon(Icons.dashboard_outlined),
              title: const Text('Tableau de bord'),
              backgroundColor: Colors.blue,
              selectedIcon: const Icon(Icons.dashboard),
            ),
            BottomBarItem(
              icon: const Icon(Icons.settings_remote_outlined),
              title: const Text('Command'),
              selectedIcon: const Icon(Icons.settings_remote),
              backgroundColor: Colors.blue,
            ),
            BottomBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              title: const Text('Profile'),
              selectedIcon: const Icon(Icons.account_circle),
              backgroundColor: Colors.blue,
            ),
          ],
          hasNotch: true,
          currentIndex: controller.selectedIndex.value,
          onTap: (index) => controller.changePage(index),
        ),
      ),
    );
  }
}
