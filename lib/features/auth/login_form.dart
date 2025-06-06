import 'package:flutter/material.dart';
import 'package:handflow/theme.dart';
import '../../data_models/input_field_state.dart';
import '../../components/password_field.dart';
// import '../components/shaking_animation.dart';
import '../../components/text_field.dart';
import '../../components/clickable_text.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart' as auth;
import '../../components/auth_dual_button.dart';

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
  bool rememberMe = false;

  void _onLoginPressed() async {
    String username = inputFields["username"]!.text;
    String password = inputFields["password"]!.text;

    // First, check for empty required fields
    bool hasEmpty = false;
    if (username == "") {
      setState(() {
        inputFields["username"]!.isErrored = true;
        inputFields["username"]!.isShaking = true;
      });
      hasEmpty = true;
    }
    if (password == "") {
      setState(() {
        inputFields["password"]!.isErrored = true;
        inputFields["password"]!.isShaking = true;
      });
      hasEmpty = true;
    }
    if (hasEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("All fields are required.")));
      return;
    }

    // Only call API if all required fields are filled
    String response = await auth.login(username, password);

    if (response == "Login successful") {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('Login successful!')),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (response == "Incorrect password") {
      setState(() {
        inputFields["password"]!.isErrored = true;
        inputFields["password"]!.isShaking = true;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Incorrect password. Please try again.")),
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          inputFields["password"]!.isShaking = false;
        });
      });
    } else if (response == "Username not found") {
      setState(() {
        inputFields["username"]!.isErrored = true;
        inputFields["username"]!.isShaking = true;
      });
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username not found. Please check your username."),
        ),
      );
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
              fieldName: 'Email',
              controller: inputFields["username"]!.controller,
              hintText: "Enter Email",
              required: true,
              isTextErrored: inputFields["username"]!.isErrored,
              keyboardType: TextInputType.text,
              isShaking: inputFields["username"]!.isShaking,
              errorMessage: inputFields["username"]!.errorMessage,
              focusNode: inputFields["username"]!.focusNode,
            ),
            PasswordField(
              fieldName: 'Password',
              controller: inputFields["password"]!.controller,
              hintText: "password",
              isPasswordErrored: inputFields["password"]!.isErrored,
              keyboardType: TextInputType.text,
              isShaking: inputFields["password"]!.isShaking,
              errorMessage: inputFields["password"]!.errorMessage,
              focusNode: inputFields["password"]!.focusNode,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (bool? newValue) {
                        if (newValue == null) return;
                        setState(() {
                          rememberMe = newValue;
                        });
                      },
                      activeColor: Colors.transparent,
                    ),
                    ClickableText(
                      text: "Remember me",
                      onTap: () {
                        rememberMe = !rememberMe;
                      },
                      underline: false,
                      // style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                ClickableText(
                  text: 'Forget Password?',
                  onTap: () {
                    null;
                  },
                  underline: false,
                  style: TextStyle(),
                ),
              ],
            ),
          ],
        ),

        ElevatedButton(onPressed: _onLoginPressed, child: Text("Log In")),
      ],
    );
  }
}
