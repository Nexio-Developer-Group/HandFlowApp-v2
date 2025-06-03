import 'package:flutter/material.dart';
import 'shaking_animation.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPasswordErrored;
  final String? errorMessage;
  final FocusNode? focusNode;
  final bool isShaking;
  final TextInputType keyboardType;

  const PasswordField({
    super.key,
    this.controller,
    this.hintText,
    this.isPasswordErrored = false,
    this.errorMessage,
    this.focusNode,
    this.isShaking = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  late TextEditingController _controller;
  bool _shouldShake = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _hasError = widget.isPasswordErrored;
    _errorMessage = widget.errorMessage;

    _controller.addListener(() {
      if (_hasError) {
        setState(() {
          _hasError = false;
          _shouldShake = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant PasswordField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isPasswordErrored != widget.isPasswordErrored ||
        oldWidget.errorMessage != widget.errorMessage ||
        oldWidget.isShaking != widget.isShaking) {
      setState(() {
        _hasError = widget.isPasswordErrored;
        _errorMessage = widget.errorMessage;
        _shouldShake = widget.isShaking;
      });

      if (widget.isShaking) {
        Future.delayed(Duration(milliseconds: 300), () {
          if (mounted) {
            setState(() {
              _shouldShake = false;
            });
          }
        });
      }
    }
  }

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
      duration: Duration(milliseconds: 300),
      shake: _shouldShake,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller,
              keyboardType: widget.keyboardType,
              obscureText: _obscureText,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                labelText: widget.hintText ?? 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  onPressed: _toggleVisibility,
                ),
                floatingLabelStyle: TextStyle(
                  color: _hasError ? Colors.red : Colors.black,
                ),
                labelStyle: TextStyle(
                  color: _hasError ? Colors.red : Colors.black,
                ),
                enabledBorder: _hasError ? inputTheme.errorBorder : null,
                focusedBorder: _hasError ? inputTheme.focusedErrorBorder : null,
                errorText: null,
              ),
            ),
            if (_hasError)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 15),
                  SizedBox(width: 5),
                  Text(
                    _errorMessage ?? "",
                    style: TextStyle(fontSize: 11.8, color: Colors.red),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
