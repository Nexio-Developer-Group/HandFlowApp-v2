import 'package:flutter/material.dart';
import 'shaking_animation.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String fieldName;
  final String? hintText;
  final bool isTextErrored;
  final String? errorMessage;
  final bool isShaking;
  final bool required;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.fieldName,
    this.hintText,
    this.errorMessage,
    this.isTextErrored = false,
    this.isShaking = false,
    this.required = true,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return ShakeWidget(
      duration: const Duration(milliseconds: 300),
      shake: isShaking,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field label
          Text(
            fieldName,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w500,
              color: Color(0xFF6C7278),
            ),
          ),
          const SizedBox(height: 2),

          TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText ?? '',
              enabledBorder:
                  isTextErrored
                      ? inputTheme.errorBorder
                      : inputTheme.enabledBorder,
              focusedBorder:
                  isTextErrored
                      ? inputTheme.focusedErrorBorder
                      : inputTheme.focusedBorder,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.5,
                horizontal: 14,
              ),
            ),
          ),

          // Optional error message
          if (isTextErrored && errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 15),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(fontSize: 11.8, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
