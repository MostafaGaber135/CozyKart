import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/core/utils/app_text_styles.dart';

class OnboardingPageItem extends StatelessWidget {
  final String imagePath, title, subTitle;
  final int currentPage, totalPages;

  const OnboardingPageItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30.h),
            Image.asset(imagePath, height: 200.h),
            SizedBox(height: 32.h),
            Text(
              title,
              style: AppTextStyles.bold23.copyWith(
                color: AppColors.primaryAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text(
              subTitle,
              style: AppTextStyles.regular22.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color:
                        currentPage == index
                            ? AppColors.primaryAccent
                            : const Color(0XFFbec6c9),
                    shape: BoxShape.circle,
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
