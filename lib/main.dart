import 'package:e_vahak/firebase_options.dart';
import 'package:e_vahak/routes/router.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: Pallete.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.backgroundColor,
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
                titleLarge: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                titleMedium: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
                bodySmall: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Pallete.primaryColor,
                ),
                bodyMedium: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Pallete.backgroundColor,
                ),
                titleSmall: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
        
      ),
      debugShowCheckedModeBanner: false,
      title: 'e-Vahak',
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        return loggedOutRoutes;
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
