import 'package:flutter/cupertino.dart';
import 'package:xcredo/src/bloc/register_bloc.dart';
import 'package:xcredo/src/resources/user_management_api.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterForm createState() => RegisterForm();
}

class RegisterForm extends State<RegisterScreen> {
  RegisterBloc registerBloc = RegisterBloc(
    authService: AuthenticationService(),
  );

  @override
  Widget build(BuildContext context) {
    return Text('data');
  }
}
