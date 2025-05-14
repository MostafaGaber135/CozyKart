import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});
  static const String routeName = '/PrivacyPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'This is the privacy policy of the app. Your personal data will be safe and secure. '
              'We never share your information with any third parties without your consent. '
              'By using our app, you agree to our terms and privacy rules.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
