import 'package:e_vahak/core/common/widgets/error.dart';
import 'package:e_vahak/core/common/widgets/loader.dart';
import 'package:e_vahak/features/auth/controller/auth_controller.dart';
import 'package:e_vahak/firebase_options.dart';
import 'package:e_vahak/routes/router.dart';
import 'package:e_vahak/theme/theme.dart';
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

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    //final authRepository = ref.watch(authRepositoryProvider);
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              theme: theme,
              debugShowCheckedModeBanner: false,
              title: 'e-Vahak',
              routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
                if (data == null) {
                  print('data null');
                  return loggedOutRoutes;
                } else {
                  print('data not null');
                  return loggedInRoutes;
                }
              }),
              routeInformationParser: const RoutemasterParser(),
            ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () =>  const Loader());
  }
}
