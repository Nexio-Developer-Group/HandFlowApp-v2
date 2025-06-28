import 'package:flutter/material.dart';
import 'package:handflow/auth/application/auth_layout_state.dart';
// import 'package:flutter/foundation.dart';
import '../../model/input_field_state.dart';

class SignupFormState extends ChangeNotifier with WidgetsBindingObserver {
  bool _isKeyboardOpen = false;
  bool _isLoading = false;
  final AuthLayoutState authLayoutState;
  SignupFormState({required this.authLayoutState});

  final Map<String, FieldState> _inputFields = {
    "email": FieldState(),
    "password": FieldState(),
    "confirmPassword": FieldState(),
  };

  // Getters
  bool get isKeyboardOpen => authLayoutState.isKeyboardOpen;
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
}
