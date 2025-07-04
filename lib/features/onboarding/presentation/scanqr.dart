import 'package:flutter/material.dart';
import 'package:handflow/shared/theme.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:provider/provider.dart';
import 'package:handflow/features/onboarding/application/onboarding_state.dart';
import 'package:handflow/features/onboarding/application/onboarding_controller.dart';

class QRScannerPage extends StatefulWidget {
  OnboardingController onboardingController;
  QRScannerPage({super.key, required this.onboardingController});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  late final OnboardingController controller;
  late final OnboardingState state;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    state = Provider.of<OnboardingState>(context, listen: false);
    controller = widget.onboardingController;
    controller.requestCameraPermission(_showPermissionDialog, context);
  }

  Future<void> _showPermissionDialog(BuildContext context) async {
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
  }

  @override
  void reassemble() {
    super.reassemble();
    controller.reassembleCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<OnboardingState>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        SizedBox(
          height: size.height * 320 / 874,
          width: size.height * 320 / 874,
          child: QRView(
            key: qrKey,
            onQRViewCreated: controller.onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.green,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: LayoutBuilder(
            builder: (context, subConstraints) {
              return Column(
                children: [
                  Spacer(),
                  Center(
                    child:
                        (state.scannedCode != null)
                            ? Container(
                              decoration: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: double.infinity,
                              height: 30,
                              alignment: Alignment.center,
                              child: Text(
                                textAlign: TextAlign.center,
                                '${state.scannedCode}',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            )
                            : Container(),
                  ),
                  Spacer(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
