import 'package:flutter/cupertino.dart';

class OnboardingScreenModel {
  final String title;
  final String description;
  final dynamic child;
  final String buttonText;
  final VoidCallback onButtonClick;
  final PageController pageController;
  final int pageCount;

  OnboardingScreenModel({
    required this.title,
    required this.description,
    required this.child,
    required this.buttonText,
    required this.onButtonClick,
    required this.pageController,
    required this.pageCount,
  });

  OnboardingScreenModel copyWith({
    String? title,
    String? description,
    dynamic child,
    String? buttonText,
    VoidCallback? onButtonClick,
    PageController? pageController,
    int? pageCount,
  }) {
    return OnboardingScreenModel(
      title: title ?? this.title,
      description: description ?? this.description,
      child: child ?? this.child,
      buttonText: buttonText ?? this.buttonText,
      onButtonClick: onButtonClick ?? this.onButtonClick,
      pageController: pageController ?? this.pageController,
      pageCount: pageCount ?? this.pageCount,
    );
  }
}
