import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  static const String routeName = '/HelpPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
              'Help & Support',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            Text(
              'If you have any questions or issues, feel free to contact our support team. '
              'We are available 24/7 to assist you with any problems related to the app usage.',
              style: TextStyle(fontSize: 14.sp, height: 1.5.h),
            ),
          ],
        ),
      ),
    );
  }
}
