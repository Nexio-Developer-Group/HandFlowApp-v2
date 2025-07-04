import 'package:flutter/material.dart';
import 'package:handflow/features/onboarding/models/onboarding_screen_model.dart';

class OnboardingState extends ChangeNotifier {
  final PageController pageController;
  late final Map<String, OnboardingScreenModel> pageContent;

  int pageCount = 8;

  OnboardingState({required this.pageController}) {
    pageContent = {
      "welcome_page": OnboardingScreenModel(
        title: "Welcome to HandFlow",
        description:
            "Experience effortless smart living. Let's setup your devices in just a few step",
        child: Container(),
        buttonText: "Next",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "instruct_scan_qr": OnboardingScreenModel(
        title: "Scan the QR Code",
        description:
            "Find and Scan the QR code on you smart device to get started. Easily control and connect you devices with a quick scan.",
        child: Container(),
        buttonText: "Next",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "scan_qr": OnboardingScreenModel(
        title: "Point towards QR Code",
        description:
            "Point the QR towards the QR Code on smart device and press scan button given below then click next.",
        child: Container(),
        buttonText: "Scan",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "confirm_device": OnboardingScreenModel(
        title: "Confirm your Device",
        description:
            "We found your device. Please confirm the details above before connecting.",
        child: Container(),
        buttonText: "Confirm",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "plugin_device": OnboardingScreenModel(
        title: "Plug In Your Device",
        description:
            "Please plug in your smart device now. We'll test the connection to ensure everything is working properly.",
        child: Container(),
        buttonText: "Start Setup",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "connection_mode": OnboardingScreenModel(
        title: "Choose Connection Mode",
        description:
            "Choose between Wi-Fi for a stable, long-range connection, or Bluetooth for a quick and easy setup. Don't worry - you can switch modes anytime later in settings.",
        child: Container(),
        buttonText: "Start Setup",
        onButtonClick: () {
          if (isWifiModeEnabled) {
            pageCount = 8;
          } else {
            pageCount = 9;
          }
          notifyListeners();
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "setup_hotspot": OnboardingScreenModel(
        title: "Set Up Your Hotspot",
        description:
            "Turn on your mobile Hotspot and set the name and password as required by your device for the initial connection. You can change this later if needed",
        child: Container(),
        buttonText: "Continue",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "setup_bluetooth": OnboardingScreenModel(
        title: "Set Up Your Bluetooth",
        description:
            "Turn on Bluetooth on your phone and make sure it's visible to nearby devices. Your device will search and connect automatically during setup.",
        child: Container(),
        buttonText: "Continue",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "pairing_device": OnboardingScreenModel(
        title: "Pairing with Your Device",
        description:
            "We've found your device nearby. Tap below to pair using Bluetooth. Make sure the device is powered on and within range.",
        child: Container(),
        buttonText: "Continue",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
      "test_connection": OnboardingScreenModel(
        title: "Testing your device",
        description:
            "Tap below to start testing your device connection. Make sure your device is plugged in and your Hotspot or choose connection mode is active.",
        child: Container(),
        buttonText: "Continue",
        onButtonClick: () {
          pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        pageController: pageController,
        pageCount: pageCount,
      ),
    };
  }

  Map<String, OnboardingScreenModel> get getPageContent => pageContent;
  PageController get getPageController => pageController;

  void updatePageContentField(
    String key, {
    String? title,
    String? description,
    dynamic child,
    String? buttonText,
    VoidCallback? onButtonClick,
    PageController? pageController,
    int? pageCount,
  }) {
    if (!pageContent.containsKey(key)) return;
    final old = pageContent[key]!;
    pageContent[key] = OnboardingScreenModel(
      title: title ?? old.title,
      description: description ?? old.description,
      child: child ?? old.child,
      buttonText: buttonText ?? old.buttonText,
      onButtonClick: onButtonClick ?? old.onButtonClick,
      pageController: pageController ?? old.pageController,
      pageCount: pageCount ?? old.pageCount,
    );
    notifyListeners();
  }

  // qr code states

  String? _scannedCode;
  String? get scannedCode => _scannedCode;

  void setScannedCode(String? code) {
    _scannedCode = code;
    updatePageContentField("scan_qr", buttonText: "Next");
    notifyListeners();
  }

  bool _cameraPermissionGranted = false;
  bool get cameraPermissionGranted => _cameraPermissionGranted;

  void setCameraPermission(bool granted) {
    _cameraPermissionGranted = granted;
    notifyListeners();
  }

  // connection mode

  bool _wifiMode = true;
  bool _bluetooth = false;

  void setBluetoothModeOn() {
    _bluetooth = true;
    _wifiMode = false;
    notifyListeners();
  }

  void setWifiModeOn() {
    _bluetooth = false;
    _wifiMode = true;
    notifyListeners();
  }

  bool get isWifiModeEnabled => _wifiMode;
  bool get isBluetoothEnabled => _bluetooth;
}
