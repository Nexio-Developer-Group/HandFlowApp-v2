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
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(fontSize: 15, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
