import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/core/widgets/main_scaffold.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});
  static const String routeName = '/AboutView';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        child: Column(
          children: [
            Image.asset('assets/images/onboarding_screen_one.png', height: 200),
            SizedBox(height: 32.h),
            Text(
              'FurniITI',
              style: AppTextStyles.bold28.copyWith(
                color: AppColors.primaryAccent,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'At Furniture, we specialize in offering designer pieces that bring style and comfort to your home. Our collection features a curated selection of timeless and contemporary furniture that fits every taste and lifestyle. From cozy sofas to elegant dining tables, each piece is crafted with quality and care in mind.',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
      title: 'About Us',
    );
  }
}
