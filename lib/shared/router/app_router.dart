import 'package:go_router/go_router.dart';
import 'package:handflow/auth/presentation/pages/auth_layout.dart';
import 'package:handflow/features/onboarding/application/onboarding_state.dart';
import '../../auth/presentation/pages/login_form.dart';
import '../../auth/presentation/pages/signup_form.dart';
import '../../features/onboarding/presentation/onboarding_layout.dart';
import '../../features/home.dart';
import 'auth_guard.dart';
import '../../auth/presentation/pages/forgot_password.dart';
import 'package:provider/provider.dart';
import '../../auth/application/signup/signup_form_state.dart';
import '../../auth/application/login/login_form_state.dart';
import '../../auth/application/forgot_password/forgot_password_state.dart';
import 'package:flutter/material.dart';

PageController _onboardingPageController = PageController();
final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) async => await authGuard(context, state),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/onboarding',
      builder:
          (context, state) => ChangeNotifierProvider(
            create:
                (_) =>
                    OnboardingState(pageController: _onboardingPageController),
            child: OnboardingLayout(),
          ),
    ),
    ShellRoute(
      builder:
          (context, state, child) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SignupFormState()),
              ChangeNotifierProvider(create: (_) => LoginFormState()),
              ChangeNotifierProvider(create: (_) => ForgotPasswordState()),
            ],
            child: Authlayout(child: child),
          ),
      routes: [
        GoRoute(
          path: '/login',
          pageBuilder:
              (context, state) => NoTransitionPage(child: const LoginForm()),
        ),
        GoRoute(
          path: '/signup',
          pageBuilder:
              (context, state) => NoTransitionPage(child: const SignupForm()),
        ),
        GoRoute(
          path: '/forgot-password',
          pageBuilder:
              (context, state) =>
                  NoTransitionPage(child: const ForgotPasswordForm()),
        ),
      ],
    ),
  ],
);
