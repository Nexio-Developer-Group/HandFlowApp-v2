import 'package:flutter/material.dart';
import 'package:handflow/shared/theme.dart';
import 'package:go_router/go_router.dart';
import 'package:handflow/shared/widgets/title_subtitle_text.dart';
import 'package:provider/provider.dart';
import '../../../shared/widgets/custom_checkbox.dart';
import '../components/password_field.dart';
import '../components/text_field.dart';
import '../components/clickable_text.dart';
import '../../application/login/login_form_state.dart';
import '../../application/login/login_controller.dart';
import '../components/auth_dual_button.dart';
import '../../../shared/widgets/gradient_elevated_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('LoginForm build');
    final screenHeight = MediaQuery.of(context).size.height;
    final uri = GoRouter.of(context).routerDelegate.currentConfiguration.uri;

    debugPrint(
      'LoginForm: email.controller.hashCode=${context.read<LoginFormState>().email.controller.hashCode}, focusNode.hashCode=${context.read<LoginFormState>().email.focusNode.hashCode}',
    );
    debugPrint(
      'LoginForm: password.controller.hashCode=${context.read<LoginFormState>().password.controller.hashCode}, focusNode.hashCode=${context.read<LoginFormState>().password.focusNode.hashCode}',
    );

    return Consumer<LoginFormState>(
      builder: (ctx, loginState, _) {
        final controller = LoginController(loginState);
        if (loginState.snackbarMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(loginState.snackbarMessage!)),
            );
            loginState.clearSnackbarMessage();
          });
        }

        // ✅ Navigate on success
        if (loginState.successNavigate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
            loginState.resetNavigationFlag();
          });
        }
        return Column(
          children: [
            if (!context.watch<LoginFormState>().isKeyboardOpen)
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.037),
                child: const TitleSubtitleText(
                  title: 'Get Started now',
                  subtitle:
                      'Create an account or log in to explore\nabout our app',
                ),
              ),
            SizedBox(height: 16),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                // onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  mainAxisAlignment:
                      !context.watch<LoginFormState>().isKeyboardOpen
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.spaceBetween,
                  children: [
                    if (!context.watch<LoginFormState>().isKeyboardOpen)
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
                          controller: loginState.email.controller,
                          hintText: "Enter Email",
                          required: true,
                          isTextErrored: loginState.email.isErrored,
                          keyboardType: TextInputType.emailAddress,
                          isShaking: loginState.email.isShaking,
                          errorMessage: loginState.email.errorMessage,
                          focusNode: loginState.email.focusNode,
                          // onChanged: (_) {
                          //   loginState.updateField(
                          //     "username",
                          //     loginState.email.copyWith(
                          //       isErrored: false,
                          //       isShaking: false,
                          //     ),
                          //   );
                          // },
                        ),
                        SizedBox(height: 16),
                        PasswordField(
                          fieldName: 'Password',
                          controller: loginState.password.controller,
                          hintText: "password",
                          isPasswordErrored: loginState.password.isErrored,
                          keyboardType: TextInputType.text,
                          isShaking: loginState.password.isShaking,
                          errorMessage: loginState.password.errorMessage,
                          focusNode: loginState.password.focusNode,
                          // onChanged: (_) {
                          //   loginState.updateField(
                          //     "password",
                          //     loginState.password.copyWith(
                          //       isErrored: false,
                          //       isShaking: false,
                          //     ),
                          //   );
                          // },
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
                                Container(
                                  margin: const EdgeInsets.all(3.96),
                                  child: CustomCheckbox(
                                    value: loginState.rememberMe,
                                    onChanged:
                                        (val) => loginState.setRememberMe(val),
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: 5),
                                ClickableText(
                                  text: "Remember me",
                                  onTap: () {
                                    loginState.setRememberMe(
                                      !loginState.rememberMe,
                                    );
                                  },
                                  underline: false,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xFF6C7278),
                                  ),
                                ),
                              ],
                            ),
                            ClickableText(
                              text: 'Forget Password ?',
                              onTap: () {
                                context.push('/forgot-password');
                              },
                              underline: false,
                              style: const TextStyle(
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
                      onPressed:
                          loginState.isLoading
                              ? null
                              : () => controller.login(),
                      child:
                          loginState.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Log In"),
                    ),
                    if (!context.watch<LoginFormState>().isKeyboardOpen)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.032,
                        ),
                        child: Image.asset('assets/logo.png'),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
