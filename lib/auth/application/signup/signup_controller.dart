import 'signup_form_state.dart';
import '../../data/auth_service.dart' as auth; 


class SignupController {
  final SignupFormState state;

  SignupController(this.state);

  Future<void> signup() async {
    // Clear previous messages
    state.setSnackbarMessage(null);
    state.setLoading(true);

    // 1. Empty field check
    bool anyEmpty = false;
    for (var key in state.inputFields.keys) {
      if (state.inputFields[key]!.text.isEmpty) {
        state.updateField(key, state.inputFields[key]!.copyWith(
          isErrored: true,
          isShaking: true,
        ));
        anyEmpty = true;
      }
    }
    if (anyEmpty) {
      state.setSnackbarMessage("All fields are required.");
      state.setLoading(false);
      return;
    }

    // 2. Password length
    if (state.password.text.length < 8) {
      state.updateField("password", state.password.copyWith(
        isErrored: true,
        isShaking: true,
      ));
      state.setSnackbarMessage("Password must be at least 8 characters long.");
      state.setLoading(false);
      return;
    }

    // 3. Password match
    if (state.password.text != state.confirmPassword.text) {
      state.updateField("confirmPassword", state.confirmPassword.copyWith(
        isErrored: true,
        isShaking: true,
      ));
      state.setSnackbarMessage("Passwords do not match.");
      state.setLoading(false);
      return;
    }

    // 4. API Call - Signup
    final result = await auth.signup(state.email.text, state.password.text);
    final int statusCode = result['statusCode'];
    final String message = result['message'] ?? '';

    if (statusCode == 200) {
      state.setSnackbarMessage(message);

      // Login after successful signup
      final loginResult = await auth.login(state.email.text, state.password.text, false);
      if (loginResult['statusCode'] == 200) {
        state.triggerSuccessNavigation();
      }
    } else if (statusCode == 400) {
      state.updateField("email", state.email.copyWith(
        isErrored: true,
        isShaking: true,
      ));
      state.setSnackbarMessage(message);
    } else {
      state.setSnackbarMessage(message);
    }

    state.setLoading(false);
  }
}
