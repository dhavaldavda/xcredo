import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xcredo/src/bloc/login_bloc.dart';
import 'package:xcredo/src/resources/user_management_api.dart';
import 'package:xcredo/src/componates/common_button.dart';
import 'package:xcredo/src/componates/common_text_field.dart';
import 'package:xcredo/src/utility/custom_navigation_bar.dart';

import '../../../utility/bottom_sheet.dart';

class AddYourProductScreen extends StatefulWidget {
  @override
  AddYourProductFormScreen createState() => AddYourProductFormScreen();
}

class AddYourProductFormScreen extends State<AddYourProductScreen> {
  final LoginBloc loginBloc = LoginBloc(authService: AuthenticationService());

  final _todayDateController = TextEditingController();
  final _categoryController = TextEditingController();
  final _subCategoryController = TextEditingController();
  final _productDescController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _measurementController = TextEditingController();
  final _perProductCostController = TextEditingController();
  final _listingPriceController = TextEditingController();
  final _productOfferController = TextEditingController();
  final _offerZoneController = TextEditingController();
  final _offerTimeController = TextEditingController();
  final _pickupTimeController = TextEditingController();
  final _netWeightController = TextEditingController();
  final _approxDeliveryController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedMeasurementUnit;
  String? _selectedDeliveryOption;

  List<XFile> selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  final List<String> _measurementUnits = [
    'Per gm',
    'Per ml',
    'Per kg',
    'Per pack of',
    'cm x mm',
  ];

  @override
  void initState() {
    super.initState();
    _todayDateController.text = DateTime.now()
        .toLocal()
        .toString()
        .split(' ')
        .first;
  }

  @override
  void dispose() {
    _todayDateController.dispose();
    _categoryController.dispose();
    _subCategoryController.dispose();
    _productDescController.dispose();
    _brandNameController.dispose();
    _measurementController.dispose();
    _perProductCostController.dispose();
    _listingPriceController.dispose();
    _productOfferController.dispose();
    _offerZoneController.dispose();
    _offerTimeController.dispose();
    _pickupTimeController.dispose();
    _netWeightController.dispose();
    _approxDeliveryController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        appBar: CustomAppBar(isFromMenu: false),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {}
            if (state is LoginFailureState) {}
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Today's Date
                        CustomTextFieldClass(
                          controller: _todayDateController,
                          placeholder: 'Today\'s Date',
                          keyBordtype: TextInputType.datetime,
                        ),
                        SizedBox(height: 20.0),

                        // Select Category
                        CustomTextFieldClass(
                          controller: _categoryController,
                          placeholder: 'Select Category',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Select SubCategory
                        CustomTextFieldClass(
                          controller: _subCategoryController,
                          placeholder: 'Select SubCategory',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Write Product Description
                        CustomTextFieldClass(
                          controller: _productDescController,
                          placeholder: 'Write Product Description',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Select Brand Name
                        CustomTextFieldClass(
                          controller: _brandNameController,
                          placeholder: 'Select Brand Name',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Product Measurement
                        CustomTextFieldClass(
                          controller: _measurementController,
                          placeholder: 'Product Measurement',
                          keyBordtype: TextInputType.number,
                        ),
                        SizedBox(height: 12.0),

                        // Measurement unit chips
                        Wrap(
                          spacing: 8,
                          children: _measurementUnits.map((unit) {
                            final selected = _selectedMeasurementUnit == unit;
                            return ChoiceChip(
                              label: Text(unit),
                              selected: selected,
                              selectedColor: Colors.blue,
                              labelStyle: TextStyle(
                                color: selected ? Colors.white : Colors.black87,
                                fontSize: 12,
                              ),
                              onSelected: (bool isSelected) {
                                setState(() {
                                  _selectedMeasurementUnit = isSelected
                                      ? unit
                                      : null;
                                });
                              },
                            );
                          }).toList(),
                        ),

                        // Add Image button
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () async {
                              String? result = await showImagePickerBottomSheet(
                                context,
                              );

                              if (result == 'camera') {
                                final XFile? image = await _picker.pickImage(
                                  source: ImageSource.camera,
                                );
                                if (image != null) {
                                  setState(() => selectedImages.add(image));
                                }
                              } else if (result == 'gallery') {
                                final List<XFile> images = await _picker
                                    .pickMultiImage();
                                if (images.isNotEmpty) {
                                  setState(() => selectedImages.addAll(images));
                                }
                              }
                            },
                            icon: Image.asset(
                              'images/add.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),

                        // Image preview list
                        (selectedImages.length) != 0
                            ? SizedBox(
                                height: 90,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedImages.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.file(
                                              File(selectedImages[index].path),
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedImages.removeAt(
                                                    index,
                                                  );
                                                });
                                              },
                                              child: Container(
                                                height: 22,
                                                width: 22,
                                                decoration: const BoxDecoration(
                                                  color: Colors.black54,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        SizedBox(height: 20.0),

                        // Per Product Cost
                        CustomTextFieldClass(
                          controller: _perProductCostController,
                          placeholder: 'Per Product Cost',
                          keyBordtype: TextInputType.number,
                        ),
                        SizedBox(height: 20.0),

                        // Listing Price
                        CustomTextFieldClass(
                          controller: _listingPriceController,
                          placeholder: 'Listing Price',
                          keyBordtype: TextInputType.number,
                        ),
                        SizedBox(height: 20.0),

                        // Product Offer Section
                        CustomTextFieldClass(
                          controller: _productOfferController,
                          placeholder: 'Product Offer Section',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Product Offer Zone Set
                        CustomTextFieldClass(
                          controller: _offerZoneController,
                          placeholder: 'Product Offer Zone Set',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Product Offer Time
                        CustomTextFieldClass(
                          controller: _offerTimeController,
                          placeholder: 'Product Offer Time',
                          keyBordtype: TextInputType.datetime,
                        ),
                        SizedBox(height: 20.0),

                        // Set Pickup Time
                        CustomTextFieldClass(
                          controller: _pickupTimeController,
                          placeholder: 'Set Pickup Time',
                          keyBordtype: TextInputType.datetime,
                        ),
                        SizedBox(height: 20.0),

                        // Net Weight of Product
                        CustomTextFieldClass(
                          controller: _netWeightController,
                          placeholder: 'Give Net Weight of Product',
                          keyBordtype: TextInputType.number,
                        ),
                        SizedBox(height: 20.0),

                        // Pickup Address
                        CustomTextFieldClass(
                          controller: _addressController,
                          placeholder: 'Select Address / Pickup Location',
                          keyBordtype: TextInputType.streetAddress,
                        ),
                        SizedBox(height: 20.0),

                        // Approx Delivery Time
                        CustomTextFieldClass(
                          controller: _approxDeliveryController,
                          placeholder: 'Approx Delivery Time',
                          keyBordtype: TextInputType.text,
                        ),
                        SizedBox(height: 20.0),

                        // Forward to Delivery toggle options
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => _selectedDeliveryOption = 'forward',
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          _selectedDeliveryOption == 'forward'
                                          ? Colors.blue
                                          : Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: _selectedDeliveryOption == 'forward'
                                        ? Colors.blue.shade50
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Forward to Delivery',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color:
                                            _selectedDeliveryOption == 'forward'
                                            ? Colors.blue
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(
                                  () => _selectedDeliveryOption = 'out',
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _selectedDeliveryOption == 'out'
                                          ? Colors.blue
                                          : Colors.grey.shade400,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: _selectedDeliveryOption == 'out'
                                        ? Colors.blue.shade50
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Is Out to Delivered',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: _selectedDeliveryOption == 'out'
                                            ? Colors.blue
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),

                        // Save
                        CustomButtonClass(onPressed: () {}, title: 'Save'),
                        SizedBox(height: 14.0),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
