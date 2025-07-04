import 'package:flutter/material.dart';

class TitleSubtitleText extends StatelessWidget {
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const TitleSubtitleText({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          title,
          style:
              titleStyle ??
              Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style:
              subtitleStyle ??
              Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6C7278),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
