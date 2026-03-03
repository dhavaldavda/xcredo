import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcredo/src/bloc/login_bloc.dart';
import 'package:xcredo/src/componates/common_button.dart';
import 'package:xcredo/src/componates/common_text_field.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/screens/user_management/change_password_screen.dart';
import 'package:xcredo/src/utility/global_variable.dart';
import '../../resources/global_font_file.dart';
import '../../utility/show_toast.dart';
import 'package:xcredo/src/resources/user_management_api.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  final LoginBloc loginBloc = LoginBloc(authService: AuthenticationService());

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundWhite,
          title: Text(''),
          leading: IconButton(
            icon: Image.asset('images/back.png', height: 30.0, width: 30.0),
            onPressed: () {
              Navigator.pop(context); // Example: Navigate back
            },
          ),
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {}
            if (state is LoginFailureState) {
              if (state.error == 'Exception: OK') {
                showToast(
                  context,
                  Icons.error,
                  'Authentication failed',
                  'error',
                );
              } else if (state.error == 'Token is required') {
                showToast(
                  context,
                  Icons.error,
                  'Please close the app, reopen it, and try again.',
                  'error',
                );
              } else {
                showToast(context, Icons.error, state.error ?? '', 'error');
              }
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height:
                      //       MediaQuery.of(context).size.height / 12, // 120
                      // ),
                      Image.asset(
                        'images/app_logo.png',
                        width: MediaQuery.of(context).size.width - 40,
                        height: 160.0,
                      ),
                      const SizedBox(height: 36.0),
                      Text(
                        'Forgot Password',
                        style: AppTextStyles.bold(
                          FontSizeType.xxl,
                          AppColors.textBlack,
                        ),
                      ),
                      const SizedBox(height: 36.0),
                      Column(
                        children: [
                          CustomTextFieldClass(
                            controller: _emailController,
                            placeholder: 'Your Email',
                            keyBordtype: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 40.0),

                          CustomButtonClass(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen(),
                                ),
                              );

                              if (_emailController.text.trim().isEmpty) {
                                showToast(
                                  context,
                                  Icons.error,
                                  'Please enter email.',
                                  'error',
                                );
                              } else if (!_emailController.text
                                  .trim()
                                  .isValidEmail()) {
                                showToast(
                                  context,
                                  Icons.error,
                                  'Please enter valid email.',
                                  'error',
                                );
                              } else {
                                loginBloc.add(
                                  LoginSubmittedEvent(
                                    email: _emailController.text.toString(),
                                    password: '',
                                  ),
                                );
                              }
                            },
                            title: 'Submit',
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),

                if (state is LoginLoadingState)
                  Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
