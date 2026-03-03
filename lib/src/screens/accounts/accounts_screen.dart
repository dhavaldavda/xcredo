import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcredo/src/bloc/login_bloc.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/resources/user_management_api.dart';
import 'package:xcredo/src/componates/common_button.dart';
import 'package:xcredo/src/componates/common_text_field.dart';
import 'package:xcredo/src/utility/custom_navigation_bar.dart';

class AccountScreen extends StatefulWidget {
  @override
  AccountFormScreen createState() => AccountFormScreen();
}

class AccountFormScreen extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  final LoginBloc loginBloc = LoginBloc(authService: AuthenticationService());

  late TabController _tabController;
  final PageController _pageController = PageController();

  // ── Business Details controllers ──────────────────────────────────────────
  final _businessNameController = TextEditingController();
  final _businessTypeController = TextEditingController();
  final _businessLevelController = TextEditingController();
  final _businessAddressController = TextEditingController();
  final _businessContactController = TextEditingController();
  XFile? _businessProfileImage;
  final ImagePicker _picker = ImagePicker();

  // ── Bank Details controllers ──────────────────────────────────────────────
  final _bankAccountController = TextEditingController();
  final _ifscCodeController = TextEditingController();

  // ── Customer Categories controllers ──────────────────────────────────────
  final _categoryController = TextEditingController();
  final _subCategoryController = TextEditingController();

  final List<String> _tabs = [
    'Business Details',
    'Bank Details',
    'Customer Categories',
    'My Orders',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _businessNameController.dispose();
    _businessTypeController.dispose();
    _businessLevelController.dispose();
    _businessAddressController.dispose();
    _businessContactController.dispose();
    _bankAccountController.dispose();
    _ifscCodeController.dispose();
    _categoryController.dispose();
    _subCategoryController.dispose();
    super.dispose();
  }

  // ── Pick profile image ────────────────────────────────────────────────────
  Future<void> _pickProfileImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final img = await _picker.pickImage(source: ImageSource.camera);
                if (img != null) setState(() => _businessProfileImage = img);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final img = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (img != null) setState(() => _businessProfileImage = img);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => loginBloc,
      child: Scaffold(
        appBar: CustomAppBar(isFromMenu: false),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                // ── 4 Tab Headers ──────────────────────────────────────────
                Container(
                  color: AppColors.backgroundWhite,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.primaryLightGreen,
                    indicatorWeight: 3,
                    labelColor: AppColors.primaryLightGreen,
                    unselectedLabelColor: AppColors.textDarkGray,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: _tabs.map((t) => Tab(text: t)).toList(),
                  ),
                ),

                // ── Pages (swipeable) ──────────────────────────────────────
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      _tabController.animateTo(index);
                    },
                    children: [
                      _businessDetailsPage(),
                      _bankDetailsPage(),
                      _customerCategoriesPage(),
                      _myOrdersPage(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── Page 1: Business Details ───────────────────────────────────────────────

  Widget _businessDetailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          // Profile image picker
          Center(
            child: GestureDetector(
              onTap: _pickProfileImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _businessProfileImage != null
                        ? FileImage(File(_businessProfileImage!.path))
                        : null,
                    child: _businessProfileImage == null
                        ? Icon(
                            Icons.business,
                            size: 50,
                            color: Colors.grey.shade400,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Business Profile Image',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 24),

          CustomTextFieldClass(
            controller: _businessNameController,
            placeholder: 'Business Name',
            keyBordtype: TextInputType.text,
          ),
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _businessTypeController,
            placeholder: 'Business Type',
            keyBordtype: TextInputType.text,
          ),
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _businessLevelController,
            placeholder: 'Business Level',
            keyBordtype: TextInputType.text,
          ),
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _businessAddressController,
            placeholder: 'Business Address',
            keyBordtype: TextInputType.streetAddress,
          ),
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _businessContactController,
            placeholder: 'Business Contact No',
            keyBordtype: TextInputType.phone,
          ),
          const SizedBox(height: 30),
          CustomButtonClass(onPressed: () {}, title: 'Save'),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  // ── Page 2: Bank Details ───────────────────────────────────────────────────

  Widget _bankDetailsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _bankAccountController,
            placeholder: 'Bank Account No',
            keyBordtype: TextInputType.number,
          ),
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _ifscCodeController,
            placeholder: 'IFSC Code',
            keyBordtype: TextInputType.text,
          ),
          const SizedBox(height: 30),
          CustomButtonClass(onPressed: () {}, title: 'Save'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Page 3: Customer Categories ────────────────────────────────────────────

  Widget _customerCategoriesPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _categoryController,
            placeholder: 'Category',
            keyBordtype: TextInputType.text,
          ),
          const SizedBox(height: 20),
          CustomTextFieldClass(
            controller: _subCategoryController,
            placeholder: 'Sub Category',
            keyBordtype: TextInputType.text,
          ),
          const SizedBox(height: 30),
          CustomButtonClass(onPressed: () {}, title: 'Save'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ── Page 4: My Orders ──────────────────────────────────────────────────────

  Widget _myOrdersPage() {
    final List<_OrderTab> orderTabs = [
      _OrderTab(label: 'Pending Order', color: Colors.orange),
      _OrderTab(label: 'Return Order', color: Colors.red),
      _OrderTab(label: 'Refund Order', color: Colors.purple),
      _OrderTab(label: 'Delivery Confirm', color: Colors.green),
      _OrderTab(label: 'Delivery Under Process', color: Colors.blue),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          ...orderTabs.map((tab) => _orderCard(tab)).toList(),
        ],
      ),
    );
  }

  Widget _orderCard(_OrderTab tab) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: tab.color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.receipt_long_outlined, color: tab.color, size: 22),
        ),
        title: Text(
          tab.label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey.shade400,
        ),
        onTap: () {
          // TODO: Navigate to order detail
        },
      ),
    );
  }
}

class _OrderTab {
  final String label;
  final Color color;

  const _OrderTab({required this.label, required this.color});
}
