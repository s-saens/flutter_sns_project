import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns_practice/firebase_options.dart';
import 'package:flutter_sns_practice/pages/page_home.dart';
import 'package:flutter_sns_practice/pages/page_login.dart';
import 'package:flutter_sns_practice/pages/page_register.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );

  MyApp({super.key});

  final seedColorProvider = StateProvider((ref) => Colors.deepPurple);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color themeSeedColor = ref.watch(seedColorProvider);
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.light, seedColor: themeSeedColor),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(brightness: Brightness.dark, seedColor: themeSeedColor),
      ),
    );
  }
}
