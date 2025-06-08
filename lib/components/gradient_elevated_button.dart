import 'package:flutter/material.dart';

/// A custom elevated button with a solid #F13B09 background and a left-to-right white gradient overlay.
class GradientElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  // Removed borderRadius, height, and padding params
  final bool enabled;

  const GradientElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.enabled = true,
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
          // Solid background color
          Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFF13B09),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          // Gradient overlay (12% white on left to 0% on right)
          Container(
            height: height,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.12), // white, 12% opacity
                  Color.fromRGBO(255, 255, 255, 0.0), // white, 0% opacity
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          // The actual button
          SizedBox(
            height: height,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: enabled ? onPressed : null,
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
        ],
      ),
    );
  }
}
