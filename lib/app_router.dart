import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handflow/layouts/auth_layout.dart';
import 'features/auth/login_form.dart';
import 'features/auth/signup_form.dart';
import 'features/onboarding/onboarding_screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/signup',
      builder: (context, state) => Authlayout(child: SignupForm()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => Authlayout(child: LoginForm()),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
  ],
);
