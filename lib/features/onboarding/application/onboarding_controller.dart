import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'onboarding_state.dart';
import 'package:flutter/material.dart';

class OnboardingController {
  final OnboardingState state;
  QRViewController? controller;

  OnboardingController(this.state);

  Future<void> requestCameraPermission(
    Function(BuildContext context)? showDialogCallback,
    BuildContext context,
  ) async {
    final status = await Permission.camera.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      if (showDialogCallback != null) {
        await showDialogCallback(context);
      }
      openAppSettings();
    }
    state.notifyListeners(); // To trigger UI update if needed
  }

  void onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    qrController.scannedDataStream.listen((scanData) {
      if (state.scannedCode == null) {
        state.setScannedCode(scanData.code);
        controller?.pauseCamera(); // Stop scanning after successful read
      }
    });
  }

  void reassembleCamera() {
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  void dispose() {
    controller?.dispose();
  }
}
