import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';

class PageViewItem extends StatelessWidget {
  final String imagePath, title, subTitle;
  final int currentPage, totalPages;

  const PageViewItem({
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(imagePath, height: 200),
            const SizedBox(height: 32),
            Text(
              title,
              style: AppTextStyles.bold23.copyWith(
                color: AppColors.primaryAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subTitle,
              style: AppTextStyles.regular22.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                totalPages,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  width: 10,
                  height: 10,
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
