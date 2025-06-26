import 'package:flutter/material.dart';
import 'shaking_animation.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldName;
  final String? hintText;
  final bool isPasswordErrored;
  final String? errorMessage;
  final FocusNode? focusNode;
  final bool isShaking;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const PasswordField({
    super.key,
    this.controller,
    this.fieldName,
    this.hintText,
    this.isPasswordErrored = false,
    this.errorMessage,
    this.focusNode,
    this.isShaking = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    final colorScheme = theme.colorScheme;

    return ShakeWidget(
      duration: const Duration(milliseconds: 300),
      shake: widget.isShaking,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.fieldName != null)
            Text(
              widget.fieldName!,
              style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
                color: Color(0xFF6C7278),
              ),
            ),
          if (widget.fieldName != null) const SizedBox(height: 2),
          TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hintText ?? '',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                ),
                onPressed: _toggleVisibility,
              ),
              enabledBorder:
                  widget.isPasswordErrored
                      ? inputTheme.errorBorder
                      : inputTheme.enabledBorder,
              focusedBorder:
                  widget.isPasswordErrored
                      ? inputTheme.focusedErrorBorder
                      : inputTheme.focusedBorder,
              errorText: null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12.5,
                horizontal: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
