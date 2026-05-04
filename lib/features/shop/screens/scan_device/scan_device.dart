import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanDeviceScreen extends StatefulWidget {
  const ScanDeviceScreen({super.key});

  @override
  State<ScanDeviceScreen> createState() => _ScanDeviceScreenState();
}

class _ScanDeviceScreenState extends State<ScanDeviceScreen> {
  MobileScannerController controller = MobileScannerController();
  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    await Permission.camera.request();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (isScanned) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code!= null) {
        setState(() => isScanned = true);
        controller.stop();
        _connectDevice(code);
      }
    }
  }

  void _connectDevice(String qrCode) {
    // Logique de connexion avec le code QR
    Get.snackbar(
      'QR détecté',
      'Connexion à l\'appareil...',
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );

    // Simule la connexion
    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => DeviceConnectingScreen(qrCode: qrCode));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Titre fixe
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Text(
              'Scanner le QR Code',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // 2. Contenu scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Scannez le code QR situé sur votre appareil',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  SizedBox(height: 24),

                  // Zone de scan
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: MobileScanner(
                        controller: controller,
                        onDetect: _onDetect,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner, color: Colors.blue, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Alignez le QR code dans le cadre',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 3. Bouton saisie manuelle en bas
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Problème de scan?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Get.to(() => ManualCodeScreen()),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'SAISIR LE CODE MANUELLEMENT',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Écran suivant après scan
class DeviceConnectingScreen extends StatelessWidget {
  final String qrCode;
  const DeviceConnectingScreen({super.key, required this.qrCode});

  @override
  Widget build(BuildContext context) {
    // Lance la connexion ici
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/home');
      Get.snackbar('Succès', 'Appareil connecté!', backgroundColor: Colors.green);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.blue),
            SizedBox(height: 24),
            Text(
              'Connexion en cours...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Code: $qrCode', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}

// Écran saisie manuelle
class ManualCodeScreen extends StatelessWidget {
  ManualCodeScreen({super.key});
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Code manuel')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'Code de l\'appareil'),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.off(() => DeviceConnectingScreen(qrCode: _codeController.text));
                },
                child: Text('CONNECTER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}