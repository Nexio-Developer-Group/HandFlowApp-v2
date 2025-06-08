import 'package:flutter/material.dart';
import 'package:handflow/theme.dart';
import '../../components/password_field.dart';
import '../../components/text_field.dart';
import 'package:go_router/go_router.dart';
// import '../../components/clickable_text.dart';
import '../../data_models/input_field_state.dart';
import '../../services/auth_service.dart' as auth;
import '../../components/auth_dual_button.dart';
import '../../components/gradient_elevated_button.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> with WidgetsBindingObserver {
  Map<String, FieldState> inputFields = {
    "email": FieldState(),
    "password": FieldState(),
    "confirmPassword": FieldState(),
  };

  void _onSignupPressed() async {
    // 1. Check for empty fields
    bool anyEmpty = false;
    for (var key in inputFields.keys) {
      if (inputFields[key]!.text == "") {
        setState(() {
          inputFields[key]!.isErrored = true;
          inputFields[key]!.isShaking = true;
        });
        anyEmpty = true;
      }
    }
    if (anyEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required.")));
      return;
    }

    // 2. Check password length first
    if (inputFields["password"]!.text.length < 8) {
      setState(() {
        inputFields["password"]!.isErrored = true;
        inputFields["password"]!.isShaking = true;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 8 characters long.")),
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["password"]!.isShaking = false;
        });
      });
      return;
    }

    // 3. Then check if passwords match
    if (inputFields["confirmPassword"]!.text != inputFields["password"]!.text) {
      setState(() {
        inputFields["confirmPassword"]!.isErrored = true;
        inputFields["confirmPassword"]!.isShaking = true;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Passwords do not match.")));
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["confirmPassword"]!.isShaking = false;
        });
      });
      return;
    }

    // 4. Call API
    final result = await auth.signup(
      inputFields["email"]!.text,
      inputFields["password"]!.text,
    );
    final int statusCode = result['statusCode'];
    final String message = result['message'] ?? '';

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(message)),
          duration: Duration(seconds: 2),
        ),
      );
      // Call login after successful signup
      final loginResult = await auth.login(
        inputFields["email"]!.text,
        inputFields["password"]!.text,
      );
      print(
        "loginResult: $loginResult ******************************************",
      );
      if (loginResult['statusCode'] == 200) {
        if (mounted) {
          context.go('/onboarding');
        }
      }
    } else if (statusCode == 400) {
      setState(() {
        inputFields["email"]!.isErrored = true;
        inputFields["email"]!.isShaking = true;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["email"]!.isShaking = false;
        });
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  void dispose() {
    for (final field in inputFields.values) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = TextTheme.of(context);
    final uri = GoRouter.of(context).routerDelegate.currentConfiguration.uri;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AuthDualButton(
          currentPath: uri.path,
          orange: orange,
          onLogin: () => context.go('/login'),
          onSignup: () => context.go('/signup'),
        ),
        Column(
          children: [
            CustomTextField(
              fieldName: "Email",
              controller: inputFields["email"]!.controller,
              focusNode: inputFields["email"]!.focusNode,
              hintText: "Email",
              required: true,
              isTextErrored: inputFields["email"]!.isErrored,
              isShaking: inputFields["email"]!.isShaking,
              keyboardType: TextInputType.emailAddress,
              errorMessage: inputFields["email"]!.errorMessage,
            ),
            SizedBox(height: 16),
            PasswordField(
              fieldName: "Password",
              controller: inputFields["password"]!.controller,
              hintText: "Password",
              isPasswordErrored: inputFields["password"]!.isErrored,
              isShaking: inputFields["password"]!.isShaking,
              focusNode: inputFields["password"]!.focusNode,
              keyboardType: TextInputType.text,
              errorMessage: inputFields["password"]!.errorMessage,
            ),
            SizedBox(height: 16),
            PasswordField(
              fieldName: "Confirm Password",
              controller: inputFields["confirmPassword"]!.controller,
              hintText: "Confirm Password",
              isPasswordErrored: inputFields["confirmPassword"]!.isErrored,
              isShaking: inputFields["confirmPassword"]!.isShaking,
              focusNode: inputFields["confirmPassword"]!.focusNode,
              keyboardType: TextInputType.text,
              errorMessage: inputFields["confirmPassword"]!.errorMessage,
            ),
          ],
        ),

        GradientElevatedButton(
          onPressed: _onSignupPressed,
          child: const Text("Sign Up"),
        ),
      ],
    );
  }
}
