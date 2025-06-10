import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

/// Checks for user info in SharedPreferences or in-memory session
Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  final accessToken = prefs.getString('access_token');
  if (email != null && accessToken != null) {
    return true;
  }
  // Check in-memory session as fallback
  final session = Session();
  return session.email != null && session.accessToken != null;
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
