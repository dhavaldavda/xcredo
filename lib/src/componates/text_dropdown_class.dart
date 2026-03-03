import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xcredo/src/resources/app_colors.dart';

import '../resources/global_font_file.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final List<Map> items;
  final void Function(String?)? onChanged;
  final Future<String>? value;
  final bool? isRequired;

  const CustomDropDown({
    required this.title,
    required this.items,
    required this.onChanged,
    this.value,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: value,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [],
              ),
            ),
            SizedBox(height: 5.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: AppTextStyles.semiBold(
                      FontSizeType.md,
                      AppColors.titleColor,
                    ),
                  ),
                  TextSpan(
                    text: ' *',
                    style: AppTextStyles.semiBold(FontSizeType.md, Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 50.0,
              child: snapshot.data != null && snapshot.data != ""
                  ? DropdownButtonFormField<String>(
                      value: snapshot.data != null ? snapshot.data : "",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'RobotoSlab',
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                      decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(10), // optional
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ), // Adjust padding as needed
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/down.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                      isExpanded: true,
                      hint: Text(title),
                      items:
                          items // Replace with your dropdown items
                              .map((Map map) {
                                return DropdownMenuItem<String>(
                                  value: map["value"].toString(),
                                  child: Text(map["label"].toString()),
                                );
                              })
                              .toList(),
                      onChanged: onChanged,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      icon: null,
                      iconSize: 0,
                    )
                  : DropdownButtonFormField<String>(
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'RobotoSlab',
                        color: Color.fromARGB(255, 119, 119, 119),
                      ),
                      decoration: InputDecoration(
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
                          borderRadius: BorderRadius.circular(10), // optional
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ), // Adjust padding as needed
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                'images/down.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                      isExpanded: true,
                      hint: Text(title),
                      items:
                          items // Replace with your dropdown items
                              .map((Map map) {
                                return DropdownMenuItem<String>(
                                  value: map["value"].toString(),
                                  child: Text(map["label"].toString()),
                                );
                              })
                              .toList(),
                      onChanged: onChanged,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      icon: null,
                      iconSize: 0,
                    ),
            ),
          ],
        );
      },
    );
  }
}
