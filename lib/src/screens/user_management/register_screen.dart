import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcredo/src/bloc/register_bloc.dart';
import 'package:xcredo/src/componates/text_dropdown_class.dart';
import 'package:xcredo/src/resources/user_management_api.dart';
import 'package:xcredo/src/utility/auth_footer.dart';
import 'package:xcredo/src/componates/common_button.dart';
import 'package:xcredo/src/componates/common_text_field.dart';
import 'package:xcredo/src/utility/global_variable.dart';
import '../../resources/global_font_file.dart';
import '../../utility/show_toast.dart';
import 'package:xcredo/src/resources/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterForm createState() => RegisterForm();
}

class RegisterForm extends State<RegisterScreen> {
  RegisterBloc registerBloc = RegisterBloc(
    authService: AuthenticationService(),
  );

  final _businessNameController = TextEditingController();
  final _businessYearController = TextEditingController();
  final _businessMonthController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _mobileNoController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _landmarkController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _businessTypeController = TextEditingController();
  final _businessLevelController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _serviceAreaController = TextEditingController();
  final _visitChargeController = TextEditingController();
  final _responseTimeController = TextEditingController();
  final _openAndCloseTimeController = TextEditingController();
  final _serviceTypeController = TextEditingController();
  final _brandNameController = TextEditingController();

  var isPasswordShow = true;
  var isConfirmPasswordShow = true;

  List<TextEditingController> partnerNameControllers = [];

  List<Map<dynamic, dynamic>> businessTypeArray = [
    {'label': 'Product and Goods', 'value': '0'},
    {'label': 'Service Center', 'value': '1'},
    {'label': 'Service Boy', 'value': '2'},
  ];

  List<Map<dynamic, dynamic>> businessLevelArray = [
    {'label': 'Retailer', 'value': '0'},
    {'label': 'Distributor', 'value': '1'},
    {'label': 'Manufacturer', 'value': '2'},
  ];

  @override
  void initState() {
    super.initState();
    _businessTypeController.text = '0';
  }

  @override
  void dispose() {
    for (var controller in partnerNameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registerBloc,
      child: Scaffold(
        body: BlocConsumer<RegisterBloc, RegistrationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height / 20, // 120
                          ),
                          Image.asset(
                            'images/app_logo.png',
                            width: MediaQuery.of(context).size.width - 40,
                            height: 160.0,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Create Account',
                            style: AppTextStyles.bold(
                              FontSizeType.xxl,
                              AppColors.textBlack,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Column(
                            children: [
                              CustomTextFieldClass(
                                controller: _businessNameController,
                                placeholder: 'Business Name',
                                keyBordtype: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextFieldClass(
                                      controller: _businessYearController,
                                      placeholder: 'Business Year',
                                      keyBordtype: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomTextFieldClass(
                                      controller: _businessMonthController,
                                      placeholder: 'Business Months',
                                      keyBordtype: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              CustomTextFieldClass(
                                controller: _ownerNameController,
                                placeholder: 'Owner Name',
                                isPlus: true,
                                keyBordtype: TextInputType.emailAddress,
                                onPlusIcon: () {
                                  setState(() {
                                    partnerNameControllers.add(
                                      TextEditingController(),
                                    );
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
                              partnerNameControllers.length > 0
                                  ? ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: partnerNameControllers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: CustomTextFieldClass(
                                            controller:
                                                partnerNameControllers[index],
                                            placeholder: 'Partner Name',
                                            isPlus: true,
                                            keyBordtype: TextInputType.text,
                                            onPlusIcon: () {
                                              setState(() {
                                                partnerNameControllers.removeAt(
                                                  index,
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  : SizedBox(),
                              // SizedBox(height: 10.0),
                              CustomTextFieldClass(
                                controller: _mobileNoController,
                                placeholder: 'Mobile No',
                                keyBordtype: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10.0),
                              CustomTextFieldClass(
                                controller: _businessAddressController,
                                placeholder: 'Business Address',
                                keyBordtype: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10.0),
                              CustomTextFieldClass(
                                controller: _address1Controller,
                                placeholder: 'Address 1',
                                keyBordtype: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10.0),
                              CustomTextFieldClass(
                                controller: _address2Controller,
                                placeholder: 'Address 2',
                                keyBordtype: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10.0),
                              CustomTextFieldClass(
                                controller: _landmarkController,
                                placeholder: 'Landmark',
                                keyBordtype: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFieldClass(
                                      controller: _countryController,
                                      placeholder: 'Country',
                                      keyBordtype: TextInputType.emailAddress,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),

                                  Expanded(
                                    child: CustomTextFieldClass(
                                      controller: _stateController,
                                      placeholder: 'State',
                                      keyBordtype: TextInputType.emailAddress,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFieldClass(
                                      controller: _cityController,
                                      placeholder: 'City',
                                      keyBordtype: TextInputType.emailAddress,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),

                                  Expanded(
                                    child: CustomTextFieldClass(
                                      controller: _pinCodeController,
                                      placeholder: 'Pin Code',
                                      keyBordtype: TextInputType.emailAddress,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              CustomDropDown(
                                value: Future.value(
                                  _businessTypeController.text,
                                ),
                                title: 'Business Type',
                                items: businessTypeArray,
                                onChanged: (value) {
                                  setState(() {
                                    _businessTypeController.text = value ?? '';
                                  });
                                },
                              ),
                              SizedBox(height: 10.0),
                              _businessTypeController.text == '0'
                                  ? CustomDropDown(
                                      value: Future.value(
                                        _businessLevelController.text,
                                      ),
                                      title: 'Business Level',
                                      items: businessLevelArray,
                                      onChanged: (value) {
                                        _businessLevelController.text =
                                            value ?? '';
                                      },
                                    )
                                  : Column(
                                      children: [
                                        CustomDropDown(
                                          value: Future.value(
                                            _serviceAreaController.text,
                                          ),
                                          title: 'Select Your Service area',
                                          items: businessTypeArray,
                                          onChanged: (value) {
                                            _serviceAreaController.text =
                                                value ?? '';
                                          },
                                        ),
                                        SizedBox(height: 10.0),
                                        CustomTextFieldClass(
                                          controller: _visitChargeController,
                                          placeholder: 'Per visit charge',
                                          keyBordtype: TextInputType.number,
                                        ),
                                        SizedBox(height: 10),
                                        CustomTextFieldClass(
                                          controller: _responseTimeController,
                                          placeholder: 'Response Time',
                                          keyBordtype: TextInputType.number,
                                        ),
                                        SizedBox(height: 10),
                                        CustomDropDown(
                                          value: Future.value(
                                            _openAndCloseTimeController.text,
                                          ),
                                          title: 'Open and Close Time',
                                          items: businessTypeArray,
                                          onChanged: (value) {
                                            _openAndCloseTimeController.text =
                                                value ?? '';
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        CustomDropDown(
                                          value: Future.value(
                                            _serviceTypeController.text,
                                          ),
                                          title: 'Service type Select',
                                          items: businessTypeArray,
                                          onChanged: (value) {
                                            _serviceTypeController.text =
                                                value ?? '';
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        CustomDropDown(
                                          value: Future.value(
                                            _brandNameController.text,
                                          ),
                                          title: 'Select Brand name',
                                          items: businessTypeArray,
                                          onChanged: (value) {
                                            _brandNameController.text =
                                                value ?? '';
                                          },
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),

                              SizedBox(height: 10.0),
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
                              SizedBox(height: 10),
                              CustomTextFieldClass(
                                keyBordtype: TextInputType.text,
                                controller: _confirmPasswordController,
                                placeholder: 'Confirm Password',
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

                              SizedBox(height: 25.0),
                              CustomButtonClass(
                                onPressed: () {
                                  print('You have clicked on sign In');
                                  if (_businessNameController.text
                                      .trim()
                                      .isEmpty) {
                                    showToast(
                                      context,
                                      Icons.error,
                                      'Please enter business name.',
                                      'error',
                                    );
                                  } else if (_businessYearController.text
                                      .trim()
                                      .isEmpty) {
                                    showToast(
                                      context,
                                      Icons.error,
                                      'Please enter valid email.',
                                      'error',
                                    );
                                  } else if (_passwordController.text
                                      .trim()
                                      .isEmpty) {
                                    showToast(
                                      context,
                                      Icons.error,
                                      'Please enter password.',
                                      'error',
                                    );
                                  } else {}
                                },
                                title: 'Sign Up',
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          AuthFooter(isFromLogin: false),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),

                if (state is RegisterLoadingState)
                  Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
