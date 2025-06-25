import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import '../input_field_state.dart';

class SignupFormState extends ChangeNotifier with WidgetsBindingObserver {
  bool _isKeyboardOpen = false;
  bool _isLoading = false;
  double _lastViewInsets = 0.0;

  final Map<String, FieldState> _inputFields = {
    "email": FieldState(),
    "password": FieldState(),
    "confirmPassword": FieldState(),
  };

  // Getters
  bool get isKeyboardOpen => _isKeyboardOpen;
  bool get isLoading => _isLoading;

  FieldState get email => _inputFields["email"]!;
  FieldState get password => _inputFields["password"]!;
  FieldState get confirmPassword => _inputFields["confirmPassword"]!;

  Map<String, FieldState> get inputFields => Map.unmodifiable(_inputFields);

  // Setters / Updaters
  void updateField(String key, FieldState newState) {
    if (_inputFields.containsKey(key)) {
      _inputFields[key] = newState;
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearSignupState() {
    _inputFields["email"] = FieldState();
    _inputFields["password"] = FieldState();
    _inputFields["confirmPassword"] = FieldState();
    notifyListeners();
  }

  void openKeyboard() {
    _isKeyboardOpen = true;
    notifyListeners();
  }

  void closeKeyboard() {
    _isKeyboardOpen = false;
    notifyListeners();
  }

  String? _snackbarMessage;
  bool _successNavigate = false;

  String? get snackbarMessage => _snackbarMessage;
  bool get successNavigate => _successNavigate;

  void setSnackbarMessage(String? message) {
    _snackbarMessage = message;
    notifyListeners();
  }

  void clearSnackbarMessage() {
    _snackbarMessage = null;
    notifyListeners();
  }

  void triggerSuccessNavigation() {
    _successNavigate = true;
    notifyListeners();
  }

  void resetNavigationFlag() {
    _successNavigate = false;
    notifyListeners();
  }

  bool _isListening = false;

  void monitorKeyboardFocus() {
    if (_isListening) return;
    _isListening = true;
    WidgetsBinding.instance.addObserver(this);
    // You can still listen to focus if you want, but don't use it for keyboard state
    // FocusManager.instance.addListener(_handleFocusChange);
  }

  @override
  void didChangeMetrics() {
    final viewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    final isKeyboardNowOpen = viewInsets > 0.0;
    if (isKeyboardNowOpen != _isKeyboardOpen) {
      _isKeyboardOpen = isKeyboardNowOpen;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // FocusManager.instance.removeListener(_handleFocusChange);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
