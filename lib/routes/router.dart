import 'package:e_vahak/features/auth/screens/login_screen.dart';
import 'package:e_vahak/features/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage<void>(child: LoginScreen()),
    '/signup': (_) => const MaterialPage<void>(child: SignUpScreen()),
  },
);
