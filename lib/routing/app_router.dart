import 'package:go_router/go_router.dart';
import 'package:handflow/layouts/auth_layout.dart';
import '../features/auth/login_form.dart';
import '../features/auth/signup_form.dart';
import '../features/onboarding/onboarding_screens.dart';
import '../features/home.dart';
import 'auth_guard.dart';
import '../features/auth/forgot_password.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) async => await authGuard(context, state),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
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
        GoRoute(
          path: '/forgot-password',
          pageBuilder:
              (context, state) =>
                  NoTransitionPage(child: const ForgotPasswordPage()),
        ),
      ],
    ),
  ],
);
