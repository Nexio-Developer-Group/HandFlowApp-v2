  import 'package:flutter/material.dart';
  import 'shaking_animation.dart';

  class CustomTextField extends StatefulWidget {
    final TextEditingController? controller;
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
          margin: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: widget.keyboardType,
                focusNode: widget.focusNode,
                controller: _controller,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: widget.hintText ?? 'Username',
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
