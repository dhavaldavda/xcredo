import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcredo/src/bloc/login_bloc.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/resources/user_management_api.dart';
import 'package:xcredo/src/utility/custom_navigation_bar.dart';
import '../../resources/global_font_file.dart';

// ── Fixed column widths ───────────────────────────────────────────────────────

const double _colDate = 100;
const double _colName = 180;
const double _colCategory = 110;
const double _colBrand = 120;
const double _colPrice = 80;
const double _colStock = 80;
const double _colStatus = 90;

const double _productTableWidth =
    _colDate +
    _colName +
    _colCategory +
    _colBrand +
    _colPrice +
    _colStock +
    _colStatus +
    6;

const double _pColName = 180;
const double _pColCategory = 110;
const double _pColBrand = 120;
const double _pColStatus = 90;
const double _pColOff = 90;
const double _pColMinQty = 80;
const double _pColDays = 90;

const double _promoTableWidth =
    _pColName +
    _pColCategory +
    _pColBrand +
    _pColStatus +
    _pColOff +
    _pColMinQty +
    _pColDays +
    6;

// ── Models ────────────────────────────────────────────────────────────────────
// NOTE: If you get a "duplicate class" error, find the OTHER file in your
// project that defines ProductItem/PromotionItem and delete those class blocks.

class ProductItem {
  final String? date;
  final String? name;
  final String? category;
  final String? brand;
  final String? price;
  final String? stock;
  final String? status;

  const ProductItem({
    this.date,
    this.name,
    this.category,
    this.brand,
    this.price,
    this.stock,
    this.status,
  });
}

class PromotionItem {
  final String? name;
  final String? category;
  final String? brand;
  final String? status;
  final String? off;
  final String? minQty;
  final String? daysLeft;

  const PromotionItem({
    this.name,
    this.category,
    this.brand,
    this.status,
    this.off,
    this.minQty,
    this.daysLeft,
  });
}

// ── Data — 20 entries each ────────────────────────────────────────────────────

final List<ProductItem> _productList = [
  ProductItem(
    date: '27/12/2025',
    name: 'Parle-G Biscuits 56.4g',
    category: 'Snacks',
    brand: 'Parle',
    price: '₹10',
    stock: '500 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '27/12/2025',
    name: 'Chin Chin Crunchy 40g',
    category: 'Snacks',
    brand: 'Chin Chin',
    price: '₹15',
    stock: '320 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '28/12/2025',
    name: 'Near East Couscous 5.9oz',
    category: 'Grocery',
    brand: 'Near East',
    price: '₹120',
    stock: '80 pcs',
    status: 'Inactive',
  ),
  ProductItem(
    date: '28/12/2025',
    name: 'Amul Butter 500g',
    category: 'Dairy',
    brand: 'Amul',
    price: '₹250',
    stock: '150 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '29/12/2025',
    name: 'Tata Tea Premium 250g',
    category: 'Beverages',
    brand: 'Tata',
    price: '₹95',
    stock: '200 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '29/12/2025',
    name: 'Maggi Noodles 70g',
    category: 'Noodles',
    brand: 'Nestle',
    price: '₹14',
    stock: '600 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '29/12/2025',
    name: 'Britannia Marie Gold 250g',
    category: 'Biscuits',
    brand: 'Britannia',
    price: '₹30',
    stock: '400 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '30/12/2025',
    name: 'Aashirvaad Atta 5kg',
    category: 'Grocery',
    brand: 'Aashirvaad',
    price: '₹280',
    stock: '90 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '30/12/2025',
    name: 'Mother Dairy Curd 400g',
    category: 'Dairy',
    brand: 'Mother Dairy',
    price: '₹45',
    stock: '120 pcs',
    status: 'Inactive',
  ),
  ProductItem(
    date: '30/12/2025',
    name: 'Dabur Honey 500g',
    category: 'Health',
    brand: 'Dabur',
    price: '₹199',
    stock: '75 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '31/12/2025',
    name: 'Haldirams Bhujia 200g',
    category: 'Snacks',
    brand: 'Haldirams',
    price: '₹60',
    stock: '250 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '31/12/2025',
    name: 'Fortune Sunflower Oil 1L',
    category: 'Oils',
    brand: 'Fortune',
    price: '₹155',
    stock: '110 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '31/12/2025',
    name: 'Vim Dishwash Bar 200g',
    category: 'Household',
    brand: 'Vim',
    price: '₹25',
    stock: '300 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '01/01/2026',
    name: 'Lifebuoy Soap 100g',
    category: 'Personal',
    brand: 'Lifebuoy',
    price: '₹28',
    stock: '350 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '01/01/2026',
    name: 'Surf Excel Detergent 1kg',
    category: 'Household',
    brand: 'Surf Excel',
    price: '₹195',
    stock: '180 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '01/01/2026',
    name: 'Colgate Strong Teeth 200g',
    category: 'Personal',
    brand: 'Colgate',
    price: '₹89',
    stock: '220 pcs',
    status: 'Inactive',
  ),
  ProductItem(
    date: '02/01/2026',
    name: 'Nescafe Classic 50g',
    category: 'Beverages',
    brand: 'Nestle',
    price: '₹135',
    stock: '95 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '02/01/2026',
    name: 'Lay\'s Classic Salted 26g',
    category: 'Snacks',
    brand: 'Lay\'s',
    price: '₹20',
    stock: '500 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '02/01/2026',
    name: 'Dettol Handwash 200ml',
    category: 'Personal',
    brand: 'Dettol',
    price: '₹99',
    stock: '140 pcs',
    status: 'Active',
  ),
  ProductItem(
    date: '03/01/2026',
    name: 'Real Fruit Juice Orange 1L',
    category: 'Beverages',
    brand: 'Dabur',
    price: '₹110',
    stock: '160 pcs',
    status: 'Active',
  ),
];

final List<PromotionItem> _promoList = [
  PromotionItem(
    name: 'Parle-G Biscuits 56.4g',
    category: 'Snacks',
    brand: 'Parle',
    status: 'Active',
    off: '20%',
    minQty: '10 pcs',
    daysLeft: '2 Days',
  ),
  PromotionItem(
    name: 'Chin Chin Crunchy 40g',
    category: 'Snacks',
    brand: 'Chin Chin',
    status: 'Active',
    off: '15%',
    minQty: '5 pcs',
    daysLeft: '3 Days',
  ),
  PromotionItem(
    name: 'Near East Couscous 5.9oz',
    category: 'Grocery',
    brand: 'Near East',
    status: 'Inactive',
    off: '10%',
    minQty: '2 pcs',
    daysLeft: '1 Day',
  ),
  PromotionItem(
    name: 'Amul Butter 500g',
    category: 'Dairy',
    brand: 'Amul',
    status: 'Active',
    off: '25%',
    minQty: '3 pcs',
    daysLeft: '5 Days',
  ),
  PromotionItem(
    name: 'Tata Tea Premium 250g',
    category: 'Beverages',
    brand: 'Tata',
    status: 'Active',
    off: '18%',
    minQty: '4 pcs',
    daysLeft: '4 Days',
  ),
  PromotionItem(
    name: 'Maggi Noodles 70g',
    category: 'Noodles',
    brand: 'Nestle',
    status: 'Active',
    off: '12%',
    minQty: '6 pcs',
    daysLeft: '7 Days',
  ),
  PromotionItem(
    name: 'Britannia Marie Gold 250g',
    category: 'Biscuits',
    brand: 'Britannia',
    status: 'Active',
    off: '8%',
    minQty: '5 pcs',
    daysLeft: '6 Days',
  ),
  PromotionItem(
    name: 'Aashirvaad Atta 5kg',
    category: 'Grocery',
    brand: 'Aashirvaad',
    status: 'Inactive',
    off: '5%',
    minQty: '2 pcs',
    daysLeft: '2 Days',
  ),
  PromotionItem(
    name: 'Mother Dairy Curd 400g',
    category: 'Dairy',
    brand: 'Mother Dairy',
    status: 'Active',
    off: '10%',
    minQty: '4 pcs',
    daysLeft: '3 Days',
  ),
  PromotionItem(
    name: 'Dabur Honey 500g',
    category: 'Health',
    brand: 'Dabur',
    status: 'Active',
    off: '22%',
    minQty: '2 pcs',
    daysLeft: '8 Days',
  ),
  PromotionItem(
    name: 'Haldirams Bhujia 200g',
    category: 'Snacks',
    brand: 'Haldirams',
    status: 'Active',
    off: '30%',
    minQty: '8 pcs',
    daysLeft: '5 Days',
  ),
  PromotionItem(
    name: 'Fortune Sunflower Oil 1L',
    category: 'Oils',
    brand: 'Fortune',
    status: 'Active',
    off: '15%',
    minQty: '3 pcs',
    daysLeft: '4 Days',
  ),
  PromotionItem(
    name: 'Vim Dishwash Bar 200g',
    category: 'Household',
    brand: 'Vim',
    status: 'Inactive',
    off: '10%',
    minQty: '5 pcs',
    daysLeft: '1 Day',
  ),
  PromotionItem(
    name: 'Lifebuoy Soap 100g',
    category: 'Personal',
    brand: 'Lifebuoy',
    status: 'Active',
    off: '20%',
    minQty: '6 pcs',
    daysLeft: '6 Days',
  ),
  PromotionItem(
    name: 'Surf Excel Detergent 1kg',
    category: 'Household',
    brand: 'Surf Excel',
    status: 'Active',
    off: '18%',
    minQty: '2 pcs',
    daysLeft: '9 Days',
  ),
  PromotionItem(
    name: 'Colgate Strong Teeth 200g',
    category: 'Personal',
    brand: 'Colgate',
    status: 'Active',
    off: '12%',
    minQty: '3 pcs',
    daysLeft: '3 Days',
  ),
  PromotionItem(
    name: 'Nescafe Classic 50g',
    category: 'Beverages',
    brand: 'Nestle',
    status: 'Active',
    off: '16%',
    minQty: '2 pcs',
    daysLeft: '7 Days',
  ),
  PromotionItem(
    name: 'Lay\'s Classic Salted 26g',
    category: 'Snacks',
    brand: 'Lay\'s',
    status: 'Inactive',
    off: '25%',
    minQty: '10 pcs',
    daysLeft: '2 Days',
  ),
  PromotionItem(
    name: 'Dettol Handwash 200ml',
    category: 'Personal',
    brand: 'Dettol',
    status: 'Active',
    off: '14%',
    minQty: '4 pcs',
    daysLeft: '5 Days',
  ),
  PromotionItem(
    name: 'Real Fruit Juice Orange 1L',
    category: 'Beverages',
    brand: 'Dabur',
    status: 'Active',
    off: '20%',
    minQty: '3 pcs',
    daysLeft: '4 Days',
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class ProductListViewAllScreen extends StatefulWidget {
  final bool isPromotion;

  ProductListViewAllScreen({required this.isPromotion});

  @override
  ProductListViewAllFormScreen createState() => ProductListViewAllFormScreen();
}

class ProductListViewAllFormScreen extends State<ProductListViewAllScreen> {
  final LoginBloc loginBloc = LoginBloc(authService: AuthenticationService());

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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5.0),
                        Text(
                          widget.isPromotion
                              ? 'Product Promotions'
                              : 'Products',
                          style: AppTextStyles.bold(FontSizeType.xxl),
                        ),
                        const SizedBox(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: widget.isPromotion
                                    ? _promoTableWidth
                                    : _productTableWidth,
                                child: Column(
                                  children: [
                                    widget.isPromotion
                                        ? _promoHeader()
                                        : _productHeader(),
                                    ...widget.isPromotion
                                        ? _promoList
                                              .map((e) => _promoRow(e))
                                              .toList()
                                        : _productList
                                              .map((e) => _productRow(e))
                                              .toList(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is LoginLoadingState)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Headers ───────────────────────────────────────────────────────────────────

Widget _productHeader() => _HeaderRow(
  cells: const [
    _HC('Date', _colDate),
    _HC('Product Name', _colName),
    _HC('Category', _colCategory),
    _HC('Brand', _colBrand),
    _HC('Price', _colPrice),
    _HC('Stock', _colStock),
    _HC('Status', _colStatus),
  ],
);

Widget _promoHeader() => _HeaderRow(
  cells: const [
    _HC('Product Name', _pColName),
    _HC('Category', _pColCategory),
    _HC('Brand', _pColBrand),
    _HC('Status', _pColStatus),
    _HC('% Off', _pColOff),
    _HC('Min Qty', _pColMinQty),
    _HC('Days Left', _pColDays),
  ],
);

// ── Rows ──────────────────────────────────────────────────────────────────────

Widget _productRow(ProductItem item) {
  final isActive = (item.status ?? '') == 'Active';
  return _DataRow(
    cells: [
      _DC(item.date ?? '', _colDate, center: true),
      _DC(item.name ?? '', _colName),
      _DC(item.category ?? '', _colCategory, center: true),
      _DC(item.brand ?? '', _colBrand, center: true),
      _DC(item.price ?? '', _colPrice, center: true),
      _DC(item.stock ?? '', _colStock, center: true),
      _DC(
        item.status ?? '',
        _colStatus,
        center: true,
        color: isActive ? Colors.green : Colors.grey,
      ),
    ],
  );
}

Widget _promoRow(PromotionItem item) {
  final isActive = (item.status ?? '') == 'Active';
  return _DataRow(
    cells: [
      _DC(item.name ?? '', _pColName),
      _DC(item.category ?? '', _pColCategory, center: true),
      _DC(item.brand ?? '', _pColBrand, center: true),
      _DC(
        item.status ?? '',
        _pColStatus,
        center: true,
        color: isActive ? Colors.green : Colors.grey,
      ),
      _DC(item.off ?? '', _pColOff, center: true),
      _DC(item.minQty ?? '', _pColMinQty, center: true),
      _DC(item.daysLeft ?? '', _pColDays, center: true),
    ],
  );
}

// ── Cell configs ──────────────────────────────────────────────────────────────

class _HC {
  final String text;
  final double width;

  const _HC(this.text, this.width);
}

class _DC {
  final String text;
  final double width;
  final bool center;
  final Color? color;

  const _DC(this.text, this.width, {this.center = false, this.color});
}

class _HeaderRow extends StatelessWidget {
  final List<_HC> cells;

  const _HeaderRow({required this.cells});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: const Color(0xFF9CC56D),
      child: Row(
        children: [
          for (int i = 0; i < cells.length; i++) ...[
            if (i > 0) Container(width: 1, color: Colors.white),
            SizedBox(
              width: cells[i].width,
              child: Center(
                child: Text(
                  cells[i].text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  final List<_DC> cells;

  const _DataRow({required this.cells});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 54,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < cells.length; i++) ...[
                if (i > 0) Container(width: 1, color: Colors.grey.shade300),
                SizedBox(
                  width: cells[i].width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: Align(
                      alignment: cells[i].center
                          ? Alignment.center
                          : Alignment.centerLeft,
                      child: Text(
                        cells[i].text,
                        style: TextStyle(
                          fontSize: 13,
                          color: cells[i].color ?? AppColors.textBlack,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(height: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
