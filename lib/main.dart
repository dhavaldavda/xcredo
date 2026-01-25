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
      navigatorKey: navigatorKey,
      title: 'Splash Screen',
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

