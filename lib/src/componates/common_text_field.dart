import 'package:flutter/material.dart';
import 'package:xcredo/src/resources/app_colors.dart';

import '../resources/global_font_file.dart';

class CustomTextFieldClass extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool isSecureText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool isReadOnly;
  final String? rightIcon;
  final void Function()? onRightIcon;
  final TextInputType keyBordtype;

  CustomTextFieldClass({
    required this.controller,
    required this.placeholder,
    this.isReadOnly = false,
    this.isSecureText = false,
    this.onChanged,
    this.onTap,
    this.rightIcon,
    this.onRightIcon,
    required this.keyBordtype,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            placeholder,
            style: AppTextStyles.semiBold(
              FontSizeType.md,
              AppColors.titleColor,
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            height: 55.0,
            child: TextFormField(
              keyboardType: keyBordtype,
              onChanged: onChanged,
              readOnly: isReadOnly,
              onTap: onTap,
              obscureText: isSecureText,
              controller: controller,

              cursorColor: Colors.black,
              style: AppTextStyles.regular(
                FontSizeType.md,
                AppColors.textDarkGray,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 11),
                hintText: placeholder,
                prefix: SizedBox(width: 16),
                hintStyle: AppTextStyles.regular(
                  FontSizeType.md,
                  AppColors.textDarkGray,
                ),
                suffixIcon: (rightIcon != null && rightIcon!.isNotEmpty)
                    ? GestureDetector(
                        onTap: onRightIcon,
                        child: Container(
                          padding: EdgeInsets.all(
                            10.0,
                          ), // Adjust padding as needed
                          height: 10.0, // Adjust height as needed
                          width: 10.0, // Adjust width as needed
                          child: Image.asset(
                            'images/$rightIcon',
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.borderLightGray,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10), // optional
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.borderLightGray,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8), // optional
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
