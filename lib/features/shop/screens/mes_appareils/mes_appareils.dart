import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osmart/features/shop/screens/scan_device/scan_device.dart';

class MesAppareilsScreen extends StatefulWidget {
  const MesAppareilsScreen({super.key});

  @override
  State<MesAppareilsScreen> createState() => _MesAppareilsScreenState();
}

class _MesAppareilsScreenState extends State<MesAppareilsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes Appareils')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => ScanDeviceScreen());
                },
                icon: Icon(Icons.add),
                label: Text('Ajouter un appareil'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
