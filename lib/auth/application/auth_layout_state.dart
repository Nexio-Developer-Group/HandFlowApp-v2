import 'package:flutter/material.dart';

class AuthLayoutState extends ChangeNotifier with WidgetsBindingObserver {
  void debugState(String from) {
    debugPrint(
      'AuthLayoutState ($from): _isKeyboardOpen=$_isKeyboardOpen, _isListening=$_isListening',
    );
  }

  bool _isKeyboardOpen = false;
  bool get isKeyboardOpen => _isKeyboardOpen;

  bool _isListening = false;

  void monitorKeyboard() {
    debugState('monitorKeyboard');
    if (_isListening) return;
    _isListening = true;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    debugState('didChangeMetrics - before');
    final bottomInset =
        WidgetsBinding
            .instance
            .platformDispatcher
            .views
            .first
            .viewInsets
            .bottom;
    final isNowOpen = bottomInset > 0.0;
    if (_isKeyboardOpen != isNowOpen) {
      _isKeyboardOpen = isNowOpen;
      notifyListeners();
      debugState('didChangeMetrics - after');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
