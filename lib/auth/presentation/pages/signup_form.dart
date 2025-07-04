import 'package:flutter/material.dart';
import 'package:handflow/shared/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:handflow/shared/widgets/title_subtitle_text.dart';
import '../components/password_field.dart';
import '../components/text_field.dart';
import '../components/auth_dual_button.dart';
import '../../../shared/widgets/gradient_elevated_button.dart';
import '../../application/signup/signup_controller.dart';
import '../../application/signup/signup_form_state.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});
  @override
  Widget build(BuildContext context) {
    final uri = GoRouter.of(context).routerDelegate.currentConfiguration.uri;
    final screenHeight = MediaQuery.of(context).size.height;

    return Consumer<SignupFormState>(
      builder: (ctx, signupState, _) {
        final controller = SignupController(signupState);
        // ✅ Show Snackbar on message
        if (signupState.snackbarMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(signupState.snackbarMessage!)),
            );
            signupState.clearSnackbarMessage();
          });
        }

        // ✅ Navigate on success
        if (signupState.successNavigate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/onboarding');
            signupState.clearSignupState();
            signupState.resetNavigationFlag();
          });
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment:
                !ctx.watch<SignupFormState>().isKeyboardOpen
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.spaceEvenly,
            children: [
              // this is top widgets
              if (!ctx.watch<SignupFormState>().isKeyboardOpen)
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.037),
                        child: const TitleSubtitleText(
                          title: 'Get Started now',
                          subtitle:
                              'Create an account or log in to explore\nabout our app',
                        ),
                      ),
                      SizedBox(height: 16),
                      AuthDualButton(
                        currentPath: uri.path,
                        orange: orange,
                        onLogin: () {
                          context.go('/login');
                          signupState.clearSignupState();
                        },
                        onSignup: () {
                          null;
                        },
                      ),
                    ],
                  ),
                ),

              Column(
                children: [
                  CustomTextField(
                    fieldName: "Email",
                    controller: signupState.email.controller,
                    focusNode: signupState.email.focusNode,
                    hintText: "Email",
                    required: true,
                    isTextErrored: signupState.email.isErrored,
                    isShaking: signupState.email.isShaking,
                    keyboardType: TextInputType.emailAddress,
                    errorMessage: signupState.email.errorMessage,
                    onChanged: (_) {
                      signupState.updateField(
                        "email",
                        signupState.email.copyWith(
                          isErrored: false,
                          isShaking: false,
                        ),
                      );
                      null;
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    fieldName: "Password",
                    controller: signupState.password.controller,
                    hintText: "Password",
                    isPasswordErrored: signupState.password.isErrored,
                    isShaking: signupState.password.isShaking,
                    focusNode: signupState.password.focusNode,
                    keyboardType: TextInputType.text,
                    errorMessage: signupState.password.errorMessage,
                    onChanged: (_) {
                      signupState.updateField(
                        "password",
                        signupState.password.copyWith(
                          isErrored: false,
                          isShaking: false,
                        ),
                      );
                      null;
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordField(
                    fieldName: "Confirm Password",
                    controller: signupState.confirmPassword.controller,
                    hintText: "Confirm Password",
                    isPasswordErrored: signupState.confirmPassword.isErrored,
                    isShaking: signupState.confirmPassword.isShaking,
                    focusNode: signupState.confirmPassword.focusNode,
                    keyboardType: TextInputType.text,
                    errorMessage: signupState.confirmPassword.errorMessage,
                    onChanged: (_) {
                      signupState.updateField(
                        "confirmPassword",
                        signupState.confirmPassword.copyWith(
                          isErrored: false,
                          isShaking: false,
                        ),
                      );
                      null;
                    },
                  ),
                ],
              ),

              SizedBox(
                child: Column(
                  children: [
                    GradientElevatedButton(
                      onPressed:
                          signupState.isLoading
                              ? null
                              : () => controller.signup(),
                      isLoading: signupState.isLoading,
                      enabled: !signupState.isLoading,
                      child: const Text("Sign Up"),
                    ),
                    if (!ctx.watch<SignupFormState>().isKeyboardOpen)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.032,
                        ),
                        child: Image.asset('assets/logo.png'),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
