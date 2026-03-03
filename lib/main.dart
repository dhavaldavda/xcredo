import 'package:flutter/material.dart';
import 'package:xcredo/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // useMaterial3: false,
        appBarTheme: const AppBarTheme(
          // backgroundColor: Colors.white,
          // elevation: 0,
          // scrolledUnderElevation: 0,
          // prevents color change on scroll
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      navigatorKey: navigatorKey,
      title: 'Splash Screen',
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
