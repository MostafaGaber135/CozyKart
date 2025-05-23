import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/generated/l10n.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});
  static const String routeName = '/PrivacyPage';

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.privacyTitle),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryAccent,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.privacyTitle,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Text(
              s.privacyContent,
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
          ],
        ),
      ),
    );
  }
}
