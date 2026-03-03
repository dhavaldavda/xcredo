import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xcredo/src/screens/user_management/login_screen.dart';
import 'package:xcredo/src/screens/user_management/register_screen.dart';

import 'global_variable.dart';

class AuthFooter extends StatelessWidget {
  final bool isFromLogin;

  AuthFooter({required this.isFromLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            text: isFromLogin
                ? 'Don’t have an account? '
                : 'Already have an account? ',
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'RobotoSlab',
              color: Color.fromARGB(255, 119, 119, 119),
            ),
            children: <TextSpan>[
              TextSpan(
                text: isFromLogin ? 'Sign up' : 'Log in!',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // open sign up screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            isFromLogin ? RegisterScreen() : LoginScreen(),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: isFromLogin
                ? 'By Log in, you agree to the '
                : 'By selecting Sign up, you agree to our ',
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'RobotoSlab',
              color: Color.fromARGB(255, 119, 119, 119),
            ),
            children: <TextSpan>[
              TextSpan(
                text: ' Terms of Service',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchLink(Uri.parse(''));
                  },
              ),
              TextSpan(
                text: ' and',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchLink(Uri.parse(''));
                  },
              ),
              TextSpan(
                text: ' Privacy Policy,',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchLink(Uri.parse(''));
                  },
              ),
              TextSpan(
                text: ' including',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchLink(Uri.parse(''));
                  },
              ),
              TextSpan(
                text: ' Cookie Use',
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'RobotoSlab',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchLink(Uri.parse(''));
                  },
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
      ],
    );
  }
}
