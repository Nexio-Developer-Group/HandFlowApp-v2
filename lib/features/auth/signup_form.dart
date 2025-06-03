import 'package:flutter/material.dart';
import '../../components/password_field.dart';
import '../../components/text_field.dart';
import 'package:go_router/go_router.dart';
import '../../components/clickable_text.dart';
import '../../data_models/input_field_state.dart';
import '../../services/auth_service.dart' as auth;

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});
  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> with WidgetsBindingObserver {
  Map<String, FieldState> inputFields = {
    "fullname": FieldState(),
    "username": FieldState(),
    "email": FieldState(),
    "password": FieldState(),
    "confirmPassword": FieldState(),
  };

  void _onSignupPressed() async {
    bool anyEmpty = false;
    for (var key in inputFields.keys) {
      if (inputFields[key]!.text == "") {
        anyEmpty = true;
        break;
      }
    }

    if (anyEmpty) {
      for (var key in inputFields.keys) {
        if (inputFields[key.toString()]!.text == "") {
          setState(() {
            inputFields[key]!.errorMessage = "Required Field";
            inputFields[key]!.isErrored = true;
            inputFields[key]!.isShaking = true;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            setState(() {
              inputFields[key]!.isShaking = false;
            });
          });
        }
      }
    } else if (inputFields["confirmPassword"]!.text !=
        inputFields["password"]!.text) {
      setState(() {
        inputFields["confirmPassword"]!.errorMessage = "Passwords do not match";
        inputFields["confirmPassword"]!.isErrored = true;
        inputFields["confirmPassword"]!.isShaking = true;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["confirmPassword"]!.isShaking = false;
        });
      });
    } else if (inputFields["password"]!.text.length < 5) {
      setState(() {
        inputFields["password"]!.errorMessage = "Minimum 8 characters";
        inputFields["password"]!.isErrored = true;
        inputFields["password"]!.isShaking = true;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["password"]!.isShaking = false;
        });
      });
    } else {
      String response = await auth.signup(
        inputFields["fullname"]!.text,
        inputFields["username"]!.text,
        inputFields["email"]!.text,
        inputFields["password"]!.text,
      );
      if (response == "Signup successful") {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('Singup Successfull!')),
              duration: Duration(seconds: 2),
            ),
          );
        });
      } else if (response == "Username already exists") {
        setState(() {
          inputFields["username"]!.errorMessage = response;
          inputFields["username"]!.isErrored = true;
          inputFields["username"]!.isShaking = true;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            inputFields["username"]!.isShaking = false;
          });
        });
      } else if (response == "Email already in use") {
        setState(() {
          inputFields["email"]!.errorMessage = response;
          inputFields["email"]!.isErrored = true;
          inputFields["email"]!.isShaking = true;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            inputFields["email"]!.isShaking = false;
          });
        });
      }
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
    TextTheme textTheme = TextTheme.of(context);
    return Column(
      children: [
        CustomTextField(
          controller: inputFields["fullname"]!.controller,
          focusNode: inputFields["fullname"]!.focusNode,
          hintText: "Full Name",
          required: true,
          isTextErrored: inputFields["fullname"]!.isErrored,
          isShaking: inputFields["fullname"]!.isShaking,
          keyboardType: TextInputType.name,
          errorMessage: inputFields["fullname"]!.errorMessage,
        ),
        CustomTextField(
          controller: inputFields["username"]!.controller,
          focusNode: inputFields["username"]!.focusNode,
          hintText: "Username",
          required: true,
          isTextErrored: inputFields["username"]!.isErrored,
          isShaking: inputFields["username"]!.isShaking,
          keyboardType: TextInputType.text,
          errorMessage: inputFields["username"]!.errorMessage,
        ),
        CustomTextField(
          controller: inputFields["email"]!.controller,
          focusNode: inputFields["email"]!.focusNode,
          hintText: "Email",
          required: true,
          isTextErrored: inputFields["email"]!.isErrored,
          isShaking: inputFields["email"]!.isShaking,
          keyboardType: TextInputType.emailAddress,
          errorMessage: inputFields["email"]!.errorMessage,
        ),
        PasswordField(
          controller: inputFields["password"]!.controller,
          hintText: "Password",
          isPasswordErrored: inputFields["password"]!.isErrored,
          isShaking: inputFields["password"]!.isShaking,
          focusNode: inputFields["password"]!.focusNode,
          keyboardType: TextInputType.text,
          errorMessage: inputFields["password"]!.errorMessage,
        ),
        PasswordField(
          controller: inputFields["confirmPassword"]!.controller,
          hintText: "Confirm Password",
          isPasswordErrored: inputFields["confirmPassword"]!.isErrored,
          isShaking: inputFields["confirmPassword"]!.isShaking,
          focusNode: inputFields["confirmPassword"]!.focusNode,
          keyboardType: TextInputType.text,
          errorMessage: inputFields["confirmPassword"]!.errorMessage,
        ),
        ElevatedButton(
          onPressed: _onSignupPressed,
          child: const Text("Sign Up"),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account? ", style: textTheme.bodySmall),
            ClickableText(
              text: "Login",
              onTap: () {
                context.go('/auth/login'); // ✅ Fixed route typo
              },
              underline: false,
            ),
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
