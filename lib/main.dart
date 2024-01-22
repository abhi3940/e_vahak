import 'package:e_vahak/core/common/widgets/error.dart';
import 'package:e_vahak/core/common/widgets/loader.dart';
import 'package:e_vahak/features/auth/repository/auth_repository.dart';
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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    //final authRepository = ref.watch(authRepositoryProvider);
    return ref.watch(authStateChangesProvider).when(
        data: (data) => MaterialApp.router(
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
                if (data == null) {
                  return loggedOutRoutes;
                } else {
                  return loggedInRoutes;
                }

              }),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () =>  const Loader());
  }
}
