import 'package:go_router/go_router.dart';
import 'package:handflow/layouts/auth_layout.dart';
import 'features/auth/login_form.dart';
import 'features/auth/signup_form.dart';
import 'features/onboarding/onboarding_screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    // Onboarding remains independent
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),

    // Persistent Auth Layout
    ShellRoute(
      builder: (context, state, child) => Authlayout(child: child),
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
      ],
    ),
  ],
);
