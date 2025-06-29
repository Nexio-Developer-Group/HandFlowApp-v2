import 'login_form_state.dart';
import '../../data/auth_service.dart' as auth;

class LoginController {
  final LoginFormState state;
  LoginController(this.state);

  Future<void> login() async {
    // Clear previous messages
    state.setSnackbarMessage(null);
    state.setLoading(true);

    // 1. Empty field check
    bool anyEmpty = false;
    for (var key in state.inputFields.keys) {
      if (state.inputFields[key]!.text.isEmpty) {
        state.updateField(
          key,
          state.inputFields[key]!.copyWith(isErrored: true, isShaking: true),
        );
        anyEmpty = true;
      }
    }
    if (anyEmpty) {
      state.setSnackbarMessage("All fields are required.");
      state.setLoading(false);
      return;
    }

    // Only call API if all required fields are filled
    final result = await auth.login(
      state.email.text,
      state.password.text,
      state.rememberMe,
    );

    final int statusCode = result['statusCode'];
    final String message = result['message'] ?? '';

    state.setLoading(false);
    state.setSnackbarMessage(message);
    if (statusCode == 200) {
      state.triggerSuccessNavigation();
    } else {
      if (statusCode == 404) {
        state.updateField(
          "username",
          state.email.copyWith(isErrored: true, isShaking: true),
        );
      } else if (statusCode == 401) {
        state.updateField(
          "password",
          state.password.copyWith(isErrored: true, isShaking: true),
        );
      }
      if (statusCode == 404) {
        Future.delayed(const Duration(milliseconds: 300), () {
          state.updateField("username", state.email.copyWith(isShaking: false));
        });
      } else if (statusCode == 401) {
        Future.delayed(const Duration(milliseconds: 300), () {
          state.updateField(
            "password",
            state.password.copyWith(isShaking: false),
          );
        });
      }
    }
  }

  
}
