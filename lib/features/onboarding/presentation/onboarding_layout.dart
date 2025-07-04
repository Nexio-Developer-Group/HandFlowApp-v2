import 'package:flutter/material.dart';
import 'package:handflow/features/onboarding/application/onboarding_controller.dart';
import 'package:handflow/features/onboarding/application/onboarding_state.dart';
import 'package:handflow/features/onboarding/presentation/scanqr.dart';
import 'package:handflow/shared/theme.dart';
import 'onboarding_screen_page.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OnboardingLayout extends StatelessWidget {
  // final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<OnboardingState>(
      builder: (ctx, onboardingState, _) {
        final controller = OnboardingController(onboardingState);
        return Scaffold(
          body: PageView(
            controller: onboardingState.getPageController,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              OnboardingScreenPage(
                model: onboardingState.getPageContent["welcome_page"]!.copyWith(
                  child: Lottie.asset(
                    'assets/animations/Welcome.json',
                    width: size.height * 320 / 874,
                    height: size.height * 320 / 874,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              OnboardingScreenPage(
                model: onboardingState.getPageContent["instruct_scan_qr"]!.copyWith(
                  child: Lottie.asset(
                    'assets/animations/animation1.json', // path to your Lottie file
                    width:
                        size.height * 320 / 874, // set width/height as needed
                    height: size.height * 320 / 874,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              OnboardingScreenPage(
                model: onboardingState.getPageContent["scan_qr"]!.copyWith(
                  child: QRScannerPage(onboardingController: controller),
                ),
              ),

              OnboardingScreenPage(
                model: onboardingState.getPageContent["confirm_device"]!.copyWith(
                  child: Lottie.asset(
                    'assets/animations/confirm_your_device.json', // path to your Lottie file
                    width:
                        size.height * 320 / 874, // set width/height as needed
                    height: size.height * 320 / 874,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              OnboardingScreenPage(
                model: onboardingState.getPageContent["plugin_device"]!.copyWith(
                  child: Lottie.asset(
                    'assets/animations/confirm_your_device.json', // path to your Lottie file
                    width:
                        size.height * 320 / 874, // set width/height as needed
                    height: size.height * 320 / 874,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              OnboardingScreenPage(
                model: onboardingState.getPageContent["connection_mode"]!
                    .copyWith(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: onboardingState.setWifiModeOn,
                            style: Theme.of(
                              context,
                            ).outlinedButtonTheme.style?.copyWith(
                              backgroundColor: WidgetStatePropertyAll(
                                onboardingState.isWifiModeEnabled
                                    ? Colors.white
                                    : const Color(0xFFFFF5F5),
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                onboardingState.isWifiModeEnabled
                                    ? orange
                                    : Colors.black54,
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color:
                                      onboardingState.isWifiModeEnabled
                                          ? orange
                                          : Colors.black26,
                                ),
                              ),
                            ),
                            child: Text("WiFi Mode"),
                          ),
                          SizedBox(height: 22),
                          OutlinedButton(
                            onPressed: onboardingState.setBluetoothModeOn,
                            style: Theme.of(
                              context,
                            ).outlinedButtonTheme.style?.copyWith(
                              backgroundColor: WidgetStatePropertyAll(
                                onboardingState.isBluetoothEnabled
                                    ? Colors.white
                                    : const Color(0xFFFFF5F5),
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                onboardingState.isBluetoothEnabled
                                    ? orange
                                    : Colors.black54,
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color:
                                      onboardingState.isBluetoothEnabled
                                          ? orange
                                          : Colors.black26,
                                ),
                              ),
                            ),
                            child: Text("BT Mode"),
                          ),
                        ],
                      ),
                    ),
              ),

              if (onboardingState.isWifiModeEnabled)
                OnboardingScreenPage(
                  model: onboardingState.getPageContent["setup_hotspot"]!.copyWith(
                    child: Lottie.asset(
                      'assets/animations/wifi_setup.json', // path to your Lottie file
                      width:
                          size.height * 320 / 874, // set width/height as needed
                      height: size.height * 320 / 874,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

              if (onboardingState.isBluetoothEnabled)
                OnboardingScreenPage(
                  model: onboardingState.getPageContent["setup_bluetooth"]!
                      .copyWith(
                        child: Lottie.asset(
                          'assets/animations/animation2.json', // path to your Lottie file
                          width:
                              size.height *
                              320 /
                              874, // set width/height as needed
                          height: size.height * 320 / 874,
                          fit: BoxFit.contain,
                        ),
                      ),
                ),
              if (onboardingState.isBluetoothEnabled)
                OnboardingScreenPage(
                  model: onboardingState.getPageContent["pairing_device"]!.copyWith(
                    child: Lottie.asset(
                      'assets/animations/pairing.json', // path to your Lottie file
                      width:
                          size.height * 320 / 874, // set width/height as needed
                      height: size.height * 320 / 874,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

              OnboardingScreenPage(
                model: onboardingState.getPageContent["test_connection"]!.copyWith(
                  child: Lottie.asset(
                    'assets/animations/test_connection.json', // path to your Lottie file
                    width:
                        size.height * 320 / 874, // set width/height as needed
                    height: size.height * 320 / 874,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
