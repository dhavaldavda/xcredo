import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcredo/src/bloc/login_bloc.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/resources/global_font_file.dart';
import 'package:xcredo/src/resources/user_management_api.dart';
import 'package:xcredo/src/screens/dashboard/product_list_cell/dashboard_list_cell.dart';
import 'package:xcredo/src/screens/dashboard/product_list_cell/dashboard_start_grid.dart';
import 'package:xcredo/src/screens/dashboard/product_list_view_all_screen.dart';
import 'package:xcredo/src/utility/custom_navigation_bar.dart';

class DashboardScreen extends StatefulWidget {
  @override
  DashboardFromScreen createState() => DashboardFromScreen();
}

class DashboardFromScreen extends State<DashboardScreen> {
  final LoginBloc loginBloc = LoginBloc(authService: AuthenticationService());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: Scaffold(
        appBar: CustomAppBar(isFromMenu: true, isFromHome: true),
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
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        Text(
                          'Dashboard',
                          style: AppTextStyles.bold(FontSizeType.xxl),
                        ),
                        SizedBox(height: 20),

                        Row(
                          children: [
                            DashboardStatCard(
                              title: 'Total Sales',
                              value: '₹7000.00',
                            ),
                            Spacer(),
                            DashboardStatCard(
                              title: 'Total Order',
                              value: "20",
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            DashboardStatCard(
                              title: 'Pending Delivery',
                              value: "15",
                            ),
                            Spacer(),
                            DashboardStatCard(title: 'Delivered', value: "5"),
                          ],
                        ),

                        SizedBox(height: 25),

                        DashboardProductListCell(
                          title: 'Product Listing Status',
                          isPromotion: false,
                          onProductViewAll: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListViewAllScreen(
                                  isPromotion: false,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 25),
                        DashboardProductListCell(
                          title: 'Product Promotion Status',
                          isPromotion: true,
                          onProductViewAll: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductListViewAllScreen(isPromotion: true),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 25),
                        _CategoryWiseSalesCard(),

                        SizedBox(height: MediaQuery.of(context).padding.bottom),
                      ],
                    ),
                  ),
                ),
                if (state is LoginLoadingState)
                  Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CategoryWiseSalesCard extends StatelessWidget {
  final _categories = [
    ('Dairy & Bakery', '₹2200', Color(0xFF5B9BD5)), // blue
    ('Snacks & Packaged Food', '₹1800', Color(0xFF70AD47)), // green
    ('Oils & Ghee', '₹1500', Color(0xFFED7D31)), // orange
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category Wise Sales',
            style: AppTextStyles.bold(FontSizeType.md, AppColors.textBlack),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _categories
                      .map(
                        (c) => Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: c.$3,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${c.$1} - ${c.$2}',
                                  style: AppTextStyles.regular(
                                    FontSizeType.sm,
                                    AppColors.textBlack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: _PieChartPainter(
                    values: [2200.0, 1800.0, 1500.0],
                    colors: [
                      Color(0xFF5B9BD5),
                      Color(0xFF70AD47),
                      Color(0xFFED7D31),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  _PieChartPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final total = values.fold<double>(0, (a, b) => a + b);
    if (total <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 4;
    var startAngle = -math.pi / 2;

    for (var i = 0; i < values.length; i++) {
      final sweepAngle = 2 * math.pi * (values[i] / total);
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw value text in segment center
      final midAngle = startAngle + sweepAngle / 2;
      final textRadius = radius * 0.6;
      final x = center.dx + textRadius * math.cos(midAngle);
      final y = center.dy + textRadius * math.sin(midAngle);
      final textPainter = TextPainter(
        text: TextSpan(
          text: values[i].toInt().toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
