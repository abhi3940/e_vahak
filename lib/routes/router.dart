import 'package:e_vahak/features/auth/screens/login_screen.dart';
import 'package:e_vahak/features/auth/screens/signup_screen.dart';
import 'package:e_vahak/features/home/screens/home_screen.dart';
import 'package:e_vahak/features/ticket/screens/add_details_screen.dart';
import 'package:e_vahak/features/ticket/screens/select_destination_screen.dart';
import 'package:e_vahak/features/ticket/screens/select_source_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage<void>(child: LoginScreen()),
    '/signup': (_) => const MaterialPage<void>(child: SignUpScreen()),
  },
);

final loggedInRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage<void>(child: HomeScreen()),
    '/selectSource': (_) => const MaterialPage<void>(child: SelectSourceScreen()),
    '/selectDestination/:index': (route) => MaterialPage(child: SelectDestinationScreen(selectedSource: int.parse(route.pathParameters['index']!))),
    '/addticketDetails': (_) => const MaterialPage<void>(child: PassengerDetails()),

  },
);
