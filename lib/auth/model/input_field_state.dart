import 'package:flutter/material.dart';

class FieldState {
  final TextEditingController controller;
  final FocusNode focusNode;
  bool isErrored;
  String? errorMessage;
  bool isShaking;

  FieldState({
    String? initialValue,
    this.isErrored = false,
    this.errorMessage,
    this.isShaking = false,
  }) : controller = TextEditingController(text: initialValue),
       focusNode = FocusNode();

  /// Getter to easily access the current text value
  String get text => controller.text;

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
