import 'package:e_vahak/firebase_options.dart';
import 'package:e_vahak/routes/router.dart';
import 'package:e_vahak/theme/pallete.dart';
import 'package:e_vahak/theme/text_theme.dart';
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

        //check out the text_theme.dart file
        // use the textTheme like style: Theme.of(context).textTheme.titleLarge,
        textTheme: textTheme,
      ),
      debugShowCheckedModeBanner: false,
      title: 'e-Vahak',
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        return loggedInRoutes;
      }),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
