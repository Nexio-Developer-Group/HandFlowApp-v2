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
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: Authlayout(child: SignupForm()),
            transitionsBuilder: _slideFromRightTransition,
          ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: Authlayout(child: LoginForm()),
            transitionsBuilder: _slideFromLeftTransition,
          ),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: OnboardingScreen(),
            transitionsBuilder: _slideTransition,
          ),
    ),
  ],
);

Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0), // Slide from right
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );
}

Widget _slideFromRightTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0), // Slide from right
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );
}

Widget _slideFromLeftTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(-1, 0), // Slide from left
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );
}
