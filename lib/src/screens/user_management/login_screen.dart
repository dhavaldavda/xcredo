import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcredo/src/bloc/login_bloc.dart';
import 'package:xcredo/src/componates/common_button.dart';
import 'package:xcredo/src/componates/common_text_field.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/screens/user_management/forgot_password_screen.dart';
import 'package:xcredo/src/utility/custom_tabbar.dart';
import 'package:xcredo/src/utility/auth_footer.dart';
import '../../resources/global_font_file.dart';
import '../../utility/show_toast.dart';
import 'package:xcredo/src/resources/user_management_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isPasswordShow = true;

  final LoginBloc loginBloc = LoginBloc(authService: AuthenticationService());

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
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
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height / 12, // 120
                        ),
                        Image.asset(
                          'images/app_logo.png',
                          width: MediaQuery.of(context).size.width - 40,
                          height: 160.0,
                        ),
                        const SizedBox(height: 36.0),
                        _buildWelcomeText(),
                        const SizedBox(height: 36.0),
                        Column(
                          children: [
                            CustomTextFieldClass(
                              controller: _emailController,
                              placeholder: 'Your Email',
                              keyBordtype: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextFieldClass(
                              keyBordtype: TextInputType.text,
                              controller: _passwordController,
                              placeholder: 'Password',
                              rightIcon: !isPasswordShow
                                  ? 'open_eye.png'
                                  : 'hide.png',
                              isSecureText: isPasswordShow,
                              onRightIcon: () {
                                setState(() {
                                  isPasswordShow = !isPasswordShow;
                                });
                              },
                            ),

                            Container(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 18,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    alignment: Alignment
                                        .centerRight, // Align text to the right
                                  ),
                                  child: Text(
                                    "Forgot password?",
                                    style: AppTextStyles.bold(
                                      FontSizeType.md,
                                      AppColors.primaryDarkGreen,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            CustomButtonClass(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CustomTabBar(selectPageIndex: 0),
                                  ),
                                );

                                // if (_emailController.text.trim().isEmpty) {
                                //   showToast(
                                //     context,
                                //     Icons.error,
                                //     'Please enter email.',
                                //     'error',
                                //   );
                                // } else if (!_emailController.text
                                //     .trim()
                                //     .isValidEmail()) {
                                //   showToast(
                                //     context,
                                //     Icons.error,
                                //     'Please enter valid email.',
                                //     'error',
                                //   );
                                // } else if (_passwordController.text
                                //     .trim()
                                //     .isEmpty) {
                                //   showToast(
                                //     context,
                                //     Icons.error,
                                //     'Please enter password.',
                                //     'error',
                                //   );
                                // } else {
                                // loginBloc.add(
                                // LoginSubmittedEvent(
                                //   email: _emailController.text.toString(),
                                //   password: _passwordController.text
                                //       .toString(),
                                // ),
                                // );
                                // }
                              },
                              title: 'Log In',
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 60,
                        // ),
                        Spacer(),
                        AuthFooter(isFromLogin: true),
                      ],
                    ),
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

  Widget _buildWelcomeText() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Welcome to ',
            style: TextStyle(color: AppColors.textBlack),
          ),
          TextSpan(
            text: 'XCRE',
            style: TextStyle(color: AppColors.primaryDarkGreen),
          ),
          TextSpan(
            text: 'DO',
            style: TextStyle(color: AppColors.primaryLightGreen),
          ),
        ],
      ),
    );
  }
}
