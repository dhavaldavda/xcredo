import 'package:flutter/material.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import '../../../resources/global_font_file.dart';

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

// ── Widget ────────────────────────────────────────────────────────────────────

class DashboardProductListCell extends StatelessWidget {
  final String title;
  final bool isPromotion;
  final void Function()? onProductViewAll;

  const DashboardProductListCell({
    super.key,
    required this.title,
    required this.isPromotion,
    this.onProductViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.textDarkGray, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDarkGray.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + View All
            Row(
              children: [
                Text(
                  title,
                  style: AppTextStyles.semiBold(
                    FontSizeType.base,
                    AppColors.textBlack,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: onProductViewAll,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.primaryLightGreen),
                    ),
                    child: Text(
                      'View All',
                      style: AppTextStyles.regular(
                        FontSizeType.base,
                        AppColors.primaryLightGreen,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Table — header + rows scroll together
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
                    width: isPromotion ? _promoTableWidth : _productTableWidth,
                    child: Column(
                      children: [
                        isPromotion ? _promoHeader() : _productHeader(),
                        ...isPromotion
                            ? dashboardPromoList
                                  .map((e) => _promoRow(e))
                                  .toList()
                            : dashboardProductList
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

Widget _productRow(DashboardProduct item) {
  final isActive = item.status == 'Active';
  return _DataRow(
    cells: [
      _DC(item.date, _colDate, center: true),
      _DC(item.name, _colName),
      _DC(item.category, _colCategory, center: true),
      _DC(item.brand, _colBrand, center: true),
      _DC(item.price, _colPrice, center: true),
      _DC(item.stock, _colStock, center: true),
      _DC(
        item.status,
        _colStatus,
        center: true,
        color: isActive ? Colors.green : Colors.grey,
      ),
    ],
  );
}

Widget _promoRow(DashboardPromotion item) {
  final isActive = item.status == 'Active';
  return _DataRow(
    cells: [
      _DC(item.name, _pColName),
      _DC(item.category, _pColCategory, center: true),
      _DC(item.brand, _pColBrand, center: true),
      _DC(
        item.status,
        _pColStatus,
        center: true,
        color: isActive ? Colors.green : Colors.grey,
      ),
      _DC(item.off, _pColOff, center: true),
      _DC(item.minQty, _pColMinQty, center: true),
      _DC(item.daysLeft, _pColDays, center: true),
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

// ── Header row ────────────────────────────────────────────────────────────────

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

// ── Data row ──────────────────────────────────────────────────────────────────

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

// ── Models — renamed to avoid ANY conflict with existing project models ────────

class DashboardProduct {
  final String date;
  final String name;
  final String category;
  final String brand;
  final String price;
  final String stock;
  final String status;

  const DashboardProduct({
    required this.date,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.stock,
    required this.status,
  });
}

class DashboardPromotion {
  final String name;
  final String category;
  final String brand;
  final String status;
  final String off;
  final String minQty;
  final String daysLeft;

  const DashboardPromotion({
    required this.name,
    required this.category,
    required this.brand,
    required this.status,
    required this.off,
    required this.minQty,
    required this.daysLeft,
  });
}

// ── Data — renamed lists to avoid conflict ────────────────────────────────────

final List<DashboardProduct> dashboardProductList = [
  DashboardProduct(
    date: '27/12/2025',
    name: 'Parle-G Biscuits 56.4g',
    category: 'Snacks',
    brand: 'Parle',
    price: '₹10',
    stock: '500 pcs',
    status: 'Active',
  ),
  DashboardProduct(
    date: '28/12/2025',
    name: 'Chin Chin Crunchy 40g',
    category: 'Snacks',
    brand: 'Chin Chin',
    price: '₹15',
    stock: '320 pcs',
    status: 'Active',
  ),
  DashboardProduct(
    date: '29/12/2025',
    name: 'Near East Couscous 5.9oz',
    category: 'Grocery',
    brand: 'Near East',
    price: '₹120',
    stock: '80 pcs',
    status: 'Inactive',
  ),
  DashboardProduct(
    date: '30/12/2025',
    name: 'Amul Butter 500g',
    category: 'Dairy',
    brand: 'Amul',
    price: '₹250',
    stock: '150 pcs',
    status: 'Active',
  ),
  DashboardProduct(
    date: '31/12/2025',
    name: 'Tata Tea Premium 250g',
    category: 'Beverages',
    brand: 'Tata',
    price: '₹95',
    stock: '200 pcs',
    status: 'Active',
  ),
];

final List<DashboardPromotion> dashboardPromoList = [
  DashboardPromotion(
    name: 'Parle-G Biscuits 56.4g',
    category: 'Snacks',
    brand: 'Parle',
    status: 'Active',
    off: '20%',
    minQty: '10 pcs',
    daysLeft: '2 Days',
  ),
  DashboardPromotion(
    name: 'Chin Chin Crunchy 40g',
    category: 'Snacks',
    brand: 'Chin Chin',
    status: 'Active',
    off: '15%',
    minQty: '5 pcs',
    daysLeft: '3 Days',
  ),
  DashboardPromotion(
    name: 'Near East Couscous 5.9oz',
    category: 'Grocery',
    brand: 'Near East',
    status: 'Inactive',
    off: '10%',
    minQty: '2 pcs',
    daysLeft: '1 Day',
  ),
  DashboardPromotion(
    name: 'Amul Butter 500g',
    category: 'Dairy',
    brand: 'Amul',
    status: 'Active',
    off: '25%',
    minQty: '3 pcs',
    daysLeft: '5 Days',
  ),
  DashboardPromotion(
    name: 'Tata Tea Premium 250g',
    category: 'Beverages',
    brand: 'Tata',
    status: 'Active',
    off: '18%',
    minQty: '4 pcs',
    daysLeft: '4 Days',
  ),
];
