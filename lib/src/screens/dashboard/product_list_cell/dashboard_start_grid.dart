import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcredo/src/resources/app_colors.dart';
import 'package:xcredo/src/resources/global_font_file.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.bold(FontSizeType.xl, AppColors.textBlack),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: AppTextStyles.semiBold(
              FontSizeType.md,
              AppColors.primaryLightGreen,
            ),
          ),
        ],
      ),
    );
  }
}
