import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../auth/data/session_storage.dart';

/// Checks for user info in SharedPreferences or in-memory session
Future<bool> isLoggedIn() async {
  if (Session().isNotEmpty) {
    return true;
  }
  return false;
}

/// GoRouter redirect logic for auth
Future<String?> authGuard(BuildContext context, GoRouterState state) async {
  final loggedIn = await isLoggedIn();
  final path = state.uri.path;

  // List of public (auth) routes
  const publicRoutes = ['/login', '/signup', '/forgot-password'];

  if (!loggedIn && !publicRoutes.contains(path)) {
    return '/login';
  }
  if (loggedIn && publicRoutes.contains(path)) {
    return '/home';
  }
  return null;
}
