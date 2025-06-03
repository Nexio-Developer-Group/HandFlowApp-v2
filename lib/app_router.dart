import 'package:go_router/go_router.dart';
// import 'package:handflow/data_models/onboarding_state.dart';
import 'package:handflow/layouts/auth_layout.dart';
import 'package:handflow/features/landing_screen/home.dart';
import 'features/auth/login_form.dart';
import 'package:flutter/material.dart';
import 'features/auth/signup_form.dart';
import 'features/onboarding/onboarding_screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Authlayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/auth/login',
          pageBuilder:
              (context, state) =>
                  NoTransitionPage(child: LoginForm(key: ValueKey('login'))),
        ),
        GoRoute(
          path: '/auth/signup',
          pageBuilder:
              (context, state) =>
                  NoTransitionPage(child: SignupForm(key: ValueKey('signup'))),
        ),
      ],
    ),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
  ],
);
