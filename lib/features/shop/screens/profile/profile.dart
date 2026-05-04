import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:osmart/features/shop/screens/mes_appareils/mes_appareils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _showLogoutBottomSheet() {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Déconnexion',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Voulez-vous vraiment vous déconnecter?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('ANNULER'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text('DÉCONNECTER'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    isDismissible: true,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white, size: 60),
                    ),
                    SizedBox(height: 8), // espace entre cercle et nom
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                shrinkWrap: true, // prend juste la hauteur nécessaire
                children: [
                  _buildMenuButton(
                    icon: Icons.mail_outline_outlined,
                    label: 'aquilasamou837@gmail.com',
                    onTap: () {},
                  ),
                  _buildMenuButton(
                    icon: Icons.devices_other_outlined,
                    label: 'Appareil connecter',
                    onTap: () {},
                    trailingText: "ESP32-HA-12",
                  ),
                  _buildMenuButton(
                    icon: Icons.devices_other_outlined,
                    label: 'Mes Appareils',
                    onTap: () {
                      Get.to(const MesAppareilsScreen());
                    },
                    trailingText: "5",
                  ),
                  _buildMenuButton(
                    icon: Icons.logout,
                    label: 'Déconnexion',
                    onTap: () {
                      _showLogoutBottomSheet();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fonction réutilisable
Widget _buildMenuButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  String? trailingText,
}) {
  return Material(
    color: Colors.white,
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22),
            SizedBox(width: 16),
            Text(label, style: TextStyle(fontSize: 16)),
            Spacer(),
            if (trailingText != null)
              Text(
                trailingText,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
          ],
        ),
      ),
    ),
  );
}
