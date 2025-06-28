import 'package:flutter/material.dart';
import 'package:handflow/auth/application/auth_layout_state.dart';
import '../../model/input_field_state.dart';

class LoginFormState extends ChangeNotifier with WidgetsBindingObserver {
  void debugState(String from) {
    debugPrint(
      'LoginFormState ($from): _isKeyboardOpen=$_isKeyboardOpen, _isLoading=$_isLoading, _rememberMe=$_rememberMe',
    );
  }

  bool _isKeyboardOpen = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  final AuthLayoutState authLayoutState;

  LoginFormState({required this.authLayoutState});
  final Map<String, FieldState> _inputFields = {
    "email": FieldState(),
    "password": FieldState(),
  };

  // Getters
  bool get isKeyboardOpen => authLayoutState.isKeyboardOpen;
  bool get isLoading => _isLoading;
  bool get rememberMe => _rememberMe;

  FieldState get email => _inputFields["email"]!;
  FieldState get password => _inputFields["password"]!;

  Map<String, FieldState> get inputFields => Map.unmodifiable(_inputFields);

  // Setters / Updaters
  void updateField(String key, FieldState newState) {
    debugState('updateField $key');
    if (_inputFields.containsKey(key)) {
      _inputFields[key] = newState;
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    debugState('setLoading');
    _isLoading = value;
    notifyListeners();
  }

  void clearSignupState() {
    debugState('clearSignupState');
    _inputFields["email"] = FieldState();
    _inputFields["password"] = FieldState();
    notifyListeners();
  }

  void openKeyboard() {
    debugState('openKeyboard');
    _isKeyboardOpen = true;
    notifyListeners();
  }

  void closeKeyboard() {
    debugState('closeKeyboard');
    print("8" * 90);
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

  void setRememberMe(bool val) {
    _rememberMe = val;
    notifyListeners();
  }
}
