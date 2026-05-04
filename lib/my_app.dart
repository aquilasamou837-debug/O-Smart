import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/shop/screens/command/command.dart';
import 'package:osmart/features/shop/screens/home/home.dart';
import 'package:osmart/features/shop/screens/profile/profile.dart';
import 'package:osmart/welcome.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylish Bottom Navigation Bar Example',
      theme: ThemeData(
        // useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      home: const WelcomeScreen(),
      //home: const AnimatedBarExample(),
    );
  }
}

//Example to setup Bubble Bottom Bar with PageView
class PrincipaleScreen extends StatefulWidget {
  const PrincipaleScreen({super.key});

  @override
  State<PrincipaleScreen> createState() => _PrincipaleScreenState();
}

class _PrincipaleScreenState extends State<PrincipaleScreen> {
  PageController controller = PageController(initialPage: 0);
  var selected = 0.obs; // GetX reactive

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          selected.value = index; // Sync quand tu swipe
        },
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
          currentIndex: selected.value,
          onTap: (index) {
            selected.value = index;
            controller.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
