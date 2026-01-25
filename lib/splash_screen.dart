
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcredo/src/screens/user_management/login_screen.dart';
import 'package:xcredo/src/utility/local_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    String? isUserLogin = await getLocalStorage('customerId');
    await Future.delayed(const Duration(seconds: 0));
    if (isUserLogin != null && isUserLogin.isNotEmpty) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CustomTabBar(
      //       selectPageIndex: 0,
      //     ),
      //   ),
      // );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child:

        Image.asset(
          'images/app_logo.png',
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
