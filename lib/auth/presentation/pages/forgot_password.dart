import 'package:flutter/material.dart';
import 'package:handflow/auth/application/forgot_password/forgot_password_state.dart';
import 'package:go_router/go_router.dart';
import 'package:handflow/shared/widgets/title_subtitle_text.dart';
import 'package:provider/provider.dart';
import '../../application/login/login_form_state.dart';
import '../../../shared/widgets/gradient_elevated_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});
  @override
  Widget build(BuildContext context) {
    // final uri = GoRouter.of(context).routerDelegate.currentConfiguration.uri;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<ForgotPasswordState>(
      builder: (ctx, forgotPasswordState, _) {
        // final controller = LoginController(ForgotPasswordState);
        if (forgotPasswordState.snackbarMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(forgotPasswordState.snackbarMessage!)),
            );
            forgotPasswordState.clearSnackbarMessage();
          });
        }

        // ✅ Navigate on success
        if (forgotPasswordState.successNavigate) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
            forgotPasswordState.resetNavigationFlag();
          });
        }
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // this is top widgets
              if (!ctx.watch<ForgotPasswordState>().isKeyboardOpen)
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.037),
                        child: const TitleSubtitleText(
                          title: 'Enter the OTP',
                          subtitle:
                              "We've sent an OTP to your email. Please enter it below.",
                        ),
                      ),
                      // SizedBox(height: 16),
                      // AuthDualButton(
                      //   currentPath: uri.path,
                      //   orange: orange,
                      //   onLogin: () {
                      //     null;
                      //   },
                      //   onSignup: () {
                      //     context.go('/signup');
                      //   },
                      // ),
                    ],
                  ),
                ),

              const Spacer(),

              Column(
                children: [
                  PinCodeTextField(
                    appContext: context,
                    length: 4, // or 4 depending on your OTP
                    keyboardType: TextInputType.number,
                    autoFocus: true,
                    obscureText: false,
                    // animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 60,
                      fieldWidth: 50,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.grey.shade100,
                      selectedFillColor: Colors.white,
                      activeColor: Colors.blue,
                      selectedColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      fieldOuterPadding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                    ),
                    // animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    // onCompleted: null,
                    onChanged: (value) {},
                  ),
                ],
              ),

              const Spacer(),

              SizedBox(
                child: Column(
                  children: [
                    GradientElevatedButton(
                      onPressed: null,
                      child:
                          forgotPasswordState.isLoading
                              ? const CircularProgressIndicator()
                              : const Text("Continue"),
                    ),
                    if (ctx.watch<LoginFormState>().isKeyboardOpen)
                      const Spacer(),
                    if (!ctx.watch<LoginFormState>().isKeyboardOpen)
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
