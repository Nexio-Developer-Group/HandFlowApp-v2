import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading; // ADD THIS

  const GradientElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false, // ADD DEFAULT
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10;
    const double height = 50;

    return Opacity(
      opacity: enabled ? 1.0 : 0.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background
          Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFF13B09),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          // Gradient overlay
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.12),
                  Color.fromRGBO(255, 255, 255, 0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          // Button layer
          SizedBox(
            height: height,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: enabled && !isLoading ? onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                padding: null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
                splashFactory: NoSplash.splashFactory,
                overlayColor: Colors.transparent,
              ),
              child: child,
            ),
          ),
          // Optional shimmer/loader overlay (minimal)
          if (isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
