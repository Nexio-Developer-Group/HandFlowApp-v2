import 'package:flutter/material.dart';

class FieldState {
  final TextEditingController controller;
  final FocusNode focusNode;
  bool isErrored;
  String? errorMessage;
  bool isShaking;

  FieldState({
    String? initialValue,
    TextEditingController? controller,
    FocusNode? focusNode,
    this.isErrored = false,
    this.errorMessage,
    this.isShaking = false,
  }) : controller = controller ?? TextEditingController(text: initialValue),
       focusNode = focusNode ?? FocusNode();

  /// Getter to easily access the current text value
  String get text => controller.text;

  /// Clone this FieldState with new values
  FieldState copyWith({
    bool? isErrored,
    String? errorMessage,
    bool? isShaking,
    String? text,
  }) {
    if (text != null && text != controller.text) {
      controller.text = text;
    }
    return FieldState._internal(
      controller: controller,
      focusNode: focusNode,
      isErrored: isErrored ?? this.isErrored,
      errorMessage: errorMessage ?? this.errorMessage,
      isShaking: isShaking ?? this.isShaking,
    );
  }

  /// Private named constructor for internal use
  FieldState._internal({
    required this.controller,
    required this.focusNode,
    required this.isErrored,
    required this.errorMessage,
    required this.isShaking,
  });

  void setError(String? message) {
    isErrored = true;
    errorMessage = message;
    isShaking = true;
  }

  void clearError() {
    isErrored = false;
    errorMessage = null;
    isShaking = false;
  }

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
