import 'package:flutter/material.dart';

class TitleSubtitleText extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSubtitleText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500, // Medium
            fontSize: 32,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400, // Regular
            fontSize: 12,
            color: Color(0xFF6C7278),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
