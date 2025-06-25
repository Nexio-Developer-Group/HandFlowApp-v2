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

  /// Clone this FieldState with new values
  FieldState copyWith({
    bool? isErrored,
    String? errorMessage,
    bool? isShaking,
    String? text, // if you want to change controller text
  }) {
    if (text != null && text != controller.text) {
      controller.text = text;
    }
    return FieldState(
      initialValue: controller.text,
      isErrored: isErrored ?? this.isErrored,
      errorMessage: errorMessage ?? this.errorMessage,
      isShaking: isShaking ?? this.isShaking,
    );
  }

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
