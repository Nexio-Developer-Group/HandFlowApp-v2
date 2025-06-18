import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:handflow/shared/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    print(Theme.of(context).scaffoldBackgroundColor);

    return Scaffold(
      body: PageView(
        // physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Page1(controller: _pageController),
          Page2(controller: _pageController),
          QRScannerPage(controller: _pageController),
        ],
      ),
    );
  }

  Widget pageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SmoothPageIndicator(
        controller: _pageController,
        count: 3,
        effect: ExpandingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          spacing: 8,
          radius: 6,
          dotColor: Colors.grey,
          activeDotColor: orange,
        ),
      ),
    );
  }

  Widget navigationButtons() {
    final textTheme = Theme.of(context).textTheme;
    // final Size screenSize = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_rounded, size: 15),
              SizedBox(width: 10),
              Text("back", style: textTheme.bodyLarge),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Next", style: TextStyle(fontSize: 16)),
                Icon(Icons.arrow_forward_ios_rounded, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Page1 extends StatelessWidget {
  final PageController controller;
  const Page1({required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/find_qr.png',
                  width: screenSize.width * 0.75,
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    radius: 6,
                    dotColor: Colors.grey,
                    activeDotColor: orange,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Welcome to HandFlow',
                      style: textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'To get started, scan the QR code on the back of your HandFlow device.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text("Next"),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center, // aligns content inside the button
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final PageController controller;
  const Page2({required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset(
                  'assets/animation.json',
                  width: screenSize.width * 0.75,
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    radius: 6,
                    dotColor: Colors.grey,
                    activeDotColor: orange,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Scan the QR Code',
                      style: textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Point your phone at the QR code on your Handflow Controller to link it with the app.',
                      style: textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                controller.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: Icon(Icons.arrow_forward),
              label: Text("Open Scanner"),
              style: ElevatedButton.styleFrom(
                alignment: Alignment.center, // aligns content inside the button
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  final PageController? controller;

  const QRScannerPage({super.key, required this.controller});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedCode;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Camera Permission'),
              content: const Text(
                'Camera permission is required to scan QR codes.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
      );
      openAppSettings(); // Let user manually enable
    }
    setState(() {}); // Trigger rebuild after permission check
  }

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    qrController.scannedDataStream.listen((scanData) {
      if (scannedCode == null) {
        setState(() {
          scannedCode = scanData.code;
        });
        controller?.pauseCamera(); // Stop scanning after successful read
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Your Device')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (scannedCode != null)
                  Text(
                    'Scanned Code: $scannedCode',
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                else
                  Text(
                    'Scanning...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: scannedCode != null ? _handleCapture : null,
                  child: const Text('Capture'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleCapture() {
    debugPrint('Captured Code: $scannedCode');
    // Navigate or handle logic as needed
  }
}
