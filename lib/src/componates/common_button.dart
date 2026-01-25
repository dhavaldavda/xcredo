import 'package:flutter/material.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/resources/global_font_file.dart';

class CustomButtonClass extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final bool isFromCart;
  final double? buttonWidth;
  final double? buttonHeight;
  final String? iconName;

  CustomButtonClass({
    required this.onPressed,
    required this.title,
    this.isFromCart = false,
    this.buttonWidth,
    this.buttonHeight = 50.0,
    this.iconName = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: !isFromCart ? MediaQuery.of(context).size.width - 18 : buttonWidth,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryLightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconName!.isNotEmpty
                ? Image.asset(
                    'images/shopping_cart_white.png',
                    height: 20,
                    width: 20,
                  )
                : Container(),
            SizedBox(
              width: iconName!.isNotEmpty ? 8.0 : 0,
            ), // Space between the icon and the text
            Center(
              child: Text(
                maxLines: 2,
                title,
                style: AppTextStyles.bold(FontSizeType.md, Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
