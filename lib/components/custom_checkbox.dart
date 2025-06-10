import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Icon(
        value ? Icons.check_box : Icons.check_box_outline_blank,
        size: size,
        color:
            value
                ? const Color(0xFFF13B09)
                : const Color(0xFF6C7278), // orange when checked, grey when not
      ),
    );
  }
}
