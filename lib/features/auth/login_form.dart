import 'package:flutter/material.dart';
import '../../data_models/input_field_state.dart';
import '../../components/password_field.dart';
// import '../components/shaking_animation.dart';
import '../../components/text_field.dart';
import '../../components/clickable_text.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart' as auth;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with WidgetsBindingObserver {
  Map<String, FieldState> inputFields = {
    "username": FieldState(),
    "password": FieldState(),
  };

  void _onLoginPressed() async {
    String username = inputFields["username"]!.text;
    String password = inputFields["password"]!.text;

    String response = await auth.login(username, password);

    if (inputFields["username"]!.text == "" ||
        inputFields["password"]!.text == "") {
      if (inputFields["username"]!.text == "") {
        setState(() {
          inputFields["username"]!.errorMessage = "Required Field";
          inputFields["username"]!.isErrored = true;
          inputFields["username"]!.isShaking = true;
        });
      }
      if (inputFields["password"]!.text == "") {
        setState(() {
          inputFields["password"]!.errorMessage = "Required Field";
          inputFields["password"]!.isErrored = true;
          inputFields["password"]!.isShaking = true;
        });
      }
    } else if (response == "Login successful") {
      null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Login Successfull!')),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (response == "Incorrect password") {
      setState(() {
        inputFields["password"]!.errorMessage = "Incorrect Password";
        inputFields["password"]!.isErrored = true;
        inputFields["password"]!.isShaking = true;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["password"]!.isShaking = false;
        });
      });
    } else if (response == "Username not found") {
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
        SizedBox(height: 5),
        CustomTextField(
          controller: inputFields["username"]!.controller,
          hintText: "username",
          required: true,
          isTextErrored: inputFields["username"]!.isErrored,
          keyboardType: TextInputType.text,
          isShaking: inputFields["username"]!.isShaking,
          errorMessage: inputFields["username"]!.errorMessage,
          focusNode: inputFields["username"]!.focusNode,
        ),
        PasswordField(
          controller: inputFields["password"]!.controller,
          hintText: "password",
          isPasswordErrored: inputFields["password"]!.isErrored,
          keyboardType: TextInputType.text,
          isShaking: inputFields["password"]!.isShaking,
          errorMessage: inputFields["password"]!.errorMessage,
          focusNode: inputFields["password"]!.focusNode,
        ),
        ElevatedButton(onPressed: _onLoginPressed, child: Text("Login")),
        SizedBox(height: 8),
        ClickableText(
          text: 'Forget Password?',
          onTap: () {
            null;
          },
          underline: false,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account? ", style: textTheme.bodySmall),
            ClickableText(
              text: "Sign Up",
              onTap: () {
                context.go('/auth/signup');
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
