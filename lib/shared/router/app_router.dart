import 'package:go_router/go_router.dart';
import 'package:handflow/auth/application/auth_layout_state.dart';
import 'package:handflow/auth/presentation/pages/auth_layout.dart';
import '../../auth/presentation/pages/login_form.dart';
import '../../auth/presentation/pages/signup_form.dart';
import '../../features/onboarding/onboarding_screens.dart';
import '../../features/home.dart';
import 'auth_guard.dart';
import '../../auth/presentation/pages/forgot_password.dart';
import 'package:provider/provider.dart';
import '../../auth/application/signup/signup_form_state.dart';
import '../../auth/application/login/login_form_state.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/signup',
  redirect: (context, state) async => await authGuard(context, state),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    ShellRoute(
      builder:
          (context, state, child) => MultiProvider(
            providers: [
              // Provide AuthLayoutState once
              ChangeNotifierProvider<AuthLayoutState>(
                create: (_) {
                  final layoutState = AuthLayoutState();
                  layoutState.monitorKeyboard();
                  return layoutState;
                },
              ),

              // SignupFormState gets AuthLayoutState via context.read
              ChangeNotifierProvider<SignupFormState>(
                create:
                    (context) => SignupFormState(
                      authLayoutState: context.read<AuthLayoutState>(),
                    ),
              ),

              // LoginFormState gets AuthLayoutState via context.read
              ChangeNotifierProvider<LoginFormState>(
                create:
                    (context) => LoginFormState(
                      authLayoutState: context.read<AuthLayoutState>(),
                    ),
              ),
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
                  NoTransitionPage(child: const ForgotPasswordPage()),
        ),
      ],
    ),
  ],
);
