import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/core/utils/app_text_styles.dart';
import 'package:cozykart/core/widgets/main_scaffold.dart';
import 'package:cozykart/generated/l10n.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});
  static const String routeName = '/AboutView';

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return MainScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        child: Column(
          children: [
            Image.asset('assets/images/onboarding_screen_one.png', height: 200),
            SizedBox(height: 32.h),
            Text(
              'ℂ𝑜𝓏𝘺𝐾𝓪𝕣𝘵',
              style: AppTextStyles.bold28.copyWith(
                color: AppColors.primaryAccent,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              local.aboutParagraph,
              textAlign: TextAlign.center,
              style: AppTextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
      title: local.aboutTitle,
    );
  }
}
