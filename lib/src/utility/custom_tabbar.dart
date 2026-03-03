import 'dart:core';
import 'package:flutter/material.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/screens/accounts/accounts_screen.dart';
import 'package:xcredo/src/screens/dashboard/dashboard_screen.dart';
import 'package:xcredo/src/screens/user_management/change_password_screen.dart';
import 'package:xcredo/src/screens/user_management/forgot_password_screen.dart';
import 'package:xcredo/src/screens/user_management/login_screen.dart';

class CustomTabBar extends StatefulWidget {
  int selectPageIndex = 0;

  CustomTabBar({required this.selectPageIndex});

  @override
  TabBarState createState() => TabBarState();
}

class TabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late List<Map<String, dynamic>> _pages;
  late AnimationController animationController;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': DashboardScreen()},
      {'page': AccountScreen()},
      {'page': ChangePasswordScreen()},
      {'page': ForgotPasswordScreen()},
    ];
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    animationController.addListener(() {
      setState(() {});
    });

    _selectedPageIndex = widget.selectPageIndex;
  }

  Widget buildBody() {
    return _pages[_selectedPageIndex]['page'];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  double getLeftPosition(int selectedIndex, BuildContext context) {
    if (selectedIndex == 0) {
      return (_selectedPageIndex * MediaQuery.of(context).size.width / 5) +
          (MediaQuery.of(context).size.width / 25 - 15);
    } else if (selectedIndex == 1) {
      return (_selectedPageIndex * MediaQuery.of(context).size.width / 5) +
          (MediaQuery.of(context).size.width / 10 - 15);
    } else if (selectedIndex == 2) {
      return (_selectedPageIndex * MediaQuery.of(context).size.width / 5) +
          (MediaQuery.of(context).size.width / 7 - 15);
    } else {
      return (_selectedPageIndex * MediaQuery.of(context).size.width / 5) +
          (MediaQuery.of(context).size.width / 5 - 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: buildBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 30,
                    child: Image.asset(
                      _selectedPageIndex == 0
                          ? 'images/home_fill.png'
                          : 'images/home.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 30,
                    child: Image.asset(
                      _selectedPageIndex == 1
                          ? 'images/home_fill.png'
                          : 'images/home.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  label: 'Account',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 30,
                    child: Image.asset(
                      _selectedPageIndex == 2
                          ? 'images/home_fill.png'
                          : 'images/home.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    height: 30,
                    child: Image.asset(
                      _selectedPageIndex == 3
                          ? 'images/home_fill.png'
                          : 'images/home.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  label: 'Home',
                ),
              ],
              currentIndex: _selectedPageIndex,
              selectedItemColor: AppColors.primaryLightGreen,
              unselectedItemColor: AppColors.textBlack,
              onTap: _onItemTapped,
            ),
            Positioned(
              top: 0,
              left: getLeftPosition(_selectedPageIndex, context),
              child: Container(
                width: 100,
                height: 3,
                color: AppColors.primaryLightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
