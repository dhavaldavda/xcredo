import 'package:flutter/material.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/screens/dashboard/add_product_list/add_your_product_screen.dart';
import '../resources/global_font_file.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Size preferredSize;
  final bool isFromMenu;
  final bool isRightIcon;
  final bool isFromHome;

  CustomAppBar({
    this.isFromMenu = true,
    this.isRightIcon = true,
    this.isFromHome = false,
    Key? key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight),
       super(key: key);

  @override
  CustomAppBarForm createState() => CustomAppBarForm();
}

class CustomAppBarForm extends State<CustomAppBar> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Keep the background color white
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade500, // Customize the color of the line
            width: 1.0, // Customize the thickness of the line
          ),
        ),
      ),
      child: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Fix the AppBar height
        child: AppBar(
          leading: widget.isFromMenu
              ? Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.textBlack,
                        size: 35.0,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                        print('you have clicked on side menu');
                      },
                    );
                  },
                )
              : IconButton(
                  icon: Image.asset(
                    'images/back.png',
                    height: 28.0,
                    width: 28.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
          centerTitle: true,
          title: Image.asset('images/app_logo.png', height: 50, width: 50),
          actions: [
            SizedBox(width: 10),
            widget.isFromHome
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddYourProductScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 180,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightGreen, // light green
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        children: [
                          /// Plus icon
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF6FA64C),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 5),

                          /// Text
                          Text(
                            'List Your Product',
                            style: AppTextStyles.regular(
                              FontSizeType.xs,
                              AppColors.backgroundWhite,
                            ),
                          ),
                          SizedBox(width: 10),

                          /// Profile image
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundImage: NetworkImage(
                                'https://i.pravatar.cc/150', // replace with your image
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(width: 15),
            widget.isFromHome
                ? GestureDetector(
                    onTap: () {
                      setState(() => isOn = !isOn);
                    },
                    child: Container(
                      width: 30,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isOn ? const Color(0xFF4CAF50) : Colors.red,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Stack(
                        children: [
                          /// White dot (radio)
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: isOn
                                ? Alignment.bottomCenter
                                : Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),

                          /// ON / OFF Text (opposite of dot)
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: isOn
                                ? Alignment.topCenter
                                : Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                isOn ? 'ON' : 'OFF',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(width: 15),
          ],
          backgroundColor: Colors.white,
          // Keep the background color white
          foregroundColor: Colors.white,
          elevation: 0.0, // Remove the default shadow
        ),
      ),
    );
  }
}
