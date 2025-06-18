// import 'package:flutter/material.dart';
// import 'shaking_animation.dart';

// class PasswordField extends StatefulWidget {
//   final TextEditingController? controller;
//   final String? hintText;
//   final bool isPasswordErrored;
//   final String? errorMessage;
//   final FocusNode? focusNode;
//   final bool isShaking;
//   final TextInputType keyboardType;

//   const PasswordField({
//     super.key,
//     this.controller,
//     this.hintText,
//     this.isPasswordErrored = false,
//     this.errorMessage,
//     this.focusNode,
//     this.isShaking = false,
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   State<PasswordField> createState() => _PasswordFieldState();
// }

// class _PasswordFieldState extends State<PasswordField> {
//   bool _obscureText = true;
//   late TextEditingController _controller;
//   bool _shouldShake = false;
//   bool _hasError = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();

//     _controller = widget.controller ?? TextEditingController();
//     _hasError = widget.isPasswordErrored;
//     _errorMessage = widget.errorMessage;

//     _controller.addListener(() {
//       if (_hasError) {
//         setState(() {
//           _hasError = false;
//           _shouldShake = false;
//         });
//       }
//     });
//   }

//   @override
//   void didUpdateWidget(covariant PasswordField oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (oldWidget.isPasswordErrored != widget.isPasswordErrored ||
//         oldWidget.errorMessage != widget.errorMessage ||
//         oldWidget.isShaking != widget.isShaking) {
//       setState(() {
//         _hasError = widget.isPasswordErrored;
//         _errorMessage = widget.errorMessage;
//         _shouldShake = widget.isShaking;
//       });

//       if (widget.isShaking) {
//         Future.delayed(Duration(milliseconds: 300), () {
//           if (mounted) {
//             setState(() {
//               _shouldShake = false;
//             });
//           }
//         });
//       }
//     }
//   }

//   void _toggleVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final inputTheme = theme.inputDecorationTheme;
//     final colorScheme = theme.colorScheme;

//     return ShakeWidget(
//       duration: Duration(milliseconds: 300),
//       shake: _shouldShake,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _controller,
//               keyboardType: widget.keyboardType,
//               obscureText: _obscureText,
//               focusNode: widget.focusNode,
//               decoration: InputDecoration(
//                 labelText: widget.hintText ?? 'Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _obscureText ? Icons.visibility_off : Icons.visibility,
//                     color: colorScheme.onSurface.withOpacity(0.6),
//                   ),
//                   onPressed: _toggleVisibility,
//                 ),
//                 floatingLabelStyle: TextStyle(
//                   color: _hasError ? Colors.red : Colors.black,
//                 ),
//                 labelStyle: TextStyle(
//                   color: _hasError ? Colors.red : Colors.black,
//                 ),
//                 enabledBorder: _hasError ? inputTheme.errorBorder : null,
//                 focusedBorder: _hasError ? inputTheme.focusedErrorBorder : null,
//                 errorText: null,
//               ),
//             ),
//             if (_hasError)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(Icons.error, color: Colors.red, size: 15),
//                   SizedBox(width: 5),
//                   Text(
//                     _errorMessage ?? "",
//                     style: TextStyle(fontSize: 11.8, color: Colors.red),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'shaking_animation.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? fieldName; // New: label shown above box
  final String? hintText;
  final bool isPasswordErrored;
  final String? errorMessage;
  final FocusNode? focusNode;
  final bool isShaking;
  final TextInputType keyboardType;

  const PasswordField({
    super.key,
    this.controller,
    this.fieldName, // added
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

            TextFormField(
              controller: _controller,
              keyboardType: widget.keyboardType,
              obscureText: _obscureText,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText ?? '',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  onPressed: _toggleVisibility,
                ),
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
