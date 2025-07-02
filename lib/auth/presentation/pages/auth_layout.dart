import 'package:flutter/material.dart';
import 'package:handflow/auth/application/login/login_form_state.dart';
import '../../../shared/widgets/scrolling_image_widget.dart';
import '../../application/signup/signup_form_state.dart';
import 'package:provider/provider.dart';

class Authlayout extends StatefulWidget {
  final Widget? child;

  const Authlayout({super.key, this.child});

  @override
  State<Authlayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<Authlayout> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    print(context.watch<SignupFormState>().isKeyboardOpen);
    super.didChangeDependencies();
    if (!_initialized) {
      final signupState = Provider.of<SignupFormState>(context, listen: false);
      final loginState = Provider.of<LoginFormState>(context, listen: false);
      loginState.monitorKeyboardFocus();
      signupState.monitorKeyboardFocus();
      _initialized = true;
      print("()" * 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupState = context.watch<SignupFormState>();
    final isKeyboardOpen = signupState.isKeyboardOpen;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive breakpoints
    double headerFraction;
    double contentFraction;
    bool show = true;

    if (screenHeight < 750) {
      headerFraction = 0;
      contentFraction = 1;
      show = false;
    } else if (screenHeight < 800) {
      // Small devices
      headerFraction = 0.20;
      contentFraction = 0.80;
    } else if (screenHeight < 900) {
      // Medium devices
      headerFraction = 0.25;
      contentFraction = 0.75;
    } else {
      // Large devices
      headerFraction = 0.263;
      contentFraction = 0.737;
    }

    // Removed PopScope, just use GestureDetector for unfocus on tap
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body:
            isKeyboardOpen
                ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (MediaQuery.of(context).size.width * 51) / 402,
                  ),
                  child: widget.child,
                )
                : show
                ? ScrollingBackground(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFE96A32), Color(0xFFF13B09)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * headerFraction,
                          child: Center(
                            child: Text(
                              'Handflow',
                              style: TextStyle(
                                fontFamily: 'EduSABeginner',
                                fontWeight: FontWeight.w600,
                                fontSize: 48,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * contentFraction,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -14,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.84,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(112),
                                      borderRadius: BorderRadius.circular(45),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(20),
                                          blurRadius: 16,
                                          offset: Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadiusDirectional.vertical(
                                        top: Radius.circular(45),
                                        bottom: Radius.circular(0),
                                      ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        (MediaQuery.of(context).size.width *
                                            51) /
                                        402,
                                  ),
                                  child: widget.child,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          (MediaQuery.of(context).size.width * 51) / 402,
                    ),
                    child: widget.child,
                  ),
                ),
      ),
    );
  }
}
