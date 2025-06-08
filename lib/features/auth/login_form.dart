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
import '../../components/gradient_elevated_button.dart';

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
    final result = await auth.login(username, password);
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
    } else {
      if (statusCode == 404) {
        setState(() {
          inputFields["username"]!.isErrored = true;
          inputFields["username"]!.isShaking = true;
        });
      } else if (statusCode == 401) {
        setState(() {
          inputFields["password"]!.isErrored = true;
          inputFields["password"]!.isShaking = true;
        });
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      if (statusCode == 404) {
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            inputFields["username"]!.isShaking = false;
          });
        });
      } else if (statusCode == 401) {
        Future.delayed(const Duration(milliseconds: 300), () {
          setState(() {
            inputFields["password"]!.isShaking = false;
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
              fieldName: 'Email',
              controller: inputFields["username"]!.controller,
              hintText: "Enter Email",
              required: true,
              isTextErrored: inputFields["username"]!.isErrored,
              keyboardType: TextInputType.emailAddress,
              isShaking: inputFields["username"]!.isShaking,
              errorMessage: inputFields["username"]!.errorMessage,
              focusNode: inputFields["username"]!.focusNode,
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          // margin: EdgeInsets.all(3.96),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: Transform.scale(
                              scale: 0.8, // Increase size by 1.5x
                              child: Checkbox(
                                value: rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        ClickableText(
                          text: "Remember me",
                          onTap: () {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                          underline: false,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF6C7278),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ClickableText(
                  text: 'Forget Password ?',
                  onTap: () {
                    null;
                  },
                  underline: false,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFFE96A32),
                  ),
                ),
              ],
            ),
          ],
        ),

        GradientElevatedButton(
          onPressed: _onLoginPressed,
          child: const Text("Log In"),
        ),
      ],
    );
  }
}
