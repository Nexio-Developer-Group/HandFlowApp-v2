import 'package:flutter/material.dart';
import 'shaking_animation.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldName; // New: field name shown above input box
  final String? hintText;
  final bool isTextErrored;
  final String? errorMessage;
  final FocusNode? focusNode;
  final bool isShaking;
  final bool required;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    this.controller,
    this.fieldName, // New param
    this.hintText,
    this.errorMessage,
    this.isTextErrored = false,
    this.focusNode,
    this.isShaking = false,
    this.required = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField>
    with WidgetsBindingObserver {
  final bool _obscureText = false;
  late TextEditingController _controller;
  bool _shouldShake = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = widget.controller ?? TextEditingController();
    _hasError = widget.isTextErrored;
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
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isTextErrored != widget.isTextErrored ||
        oldWidget.errorMessage != widget.errorMessage ||
        oldWidget.isShaking != widget.isShaking) {
      setState(() {
        _hasError = widget.isTextErrored;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return ShakeWidget(
      duration: Duration(milliseconds: 300),
      shake: _shouldShake,
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.fieldName != null)
              Text(
                widget.fieldName!,
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6C7278),
                ),
              ),

            if (widget.fieldName != null) SizedBox(height: 2),
            TextField(
              keyboardType: widget.keyboardType,
              focusNode: widget.focusNode,
              controller: _controller,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: widget.hintText ?? '',
                enabledBorder:
                    _hasError
                        ? inputTheme.errorBorder
                        : inputTheme.enabledBorder,
                focusedBorder:
                    _hasError
                        ? inputTheme.focusedErrorBorder
                        : inputTheme.focusedBorder,
                errorText: null,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.5,
                  horizontal: 14,
                ),
              ),
            ),

            // if (_hasError)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 4),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Icon(Icons.error, color: Colors.red, size: 15),
            //         SizedBox(width: 5),
            //         Expanded(
            //           child: Text(
            //             _errorMessage ?? "",
            //             style: TextStyle(fontSize: 11.8, color: Colors.red),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
