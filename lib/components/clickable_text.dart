import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;
  final Color? color;
  final bool underline;

  const ClickableText({
    Key? key,
    required this.text,
    required this.onTap,
    this.style,
    this.color,
    this.underline = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = color ?? theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: style ??
            theme.textTheme.bodyMedium?.copyWith(
              color: defaultColor,
              decoration: underline ? TextDecoration.underline : TextDecoration.none,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
