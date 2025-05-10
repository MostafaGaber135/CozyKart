import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: Color(0xFFDCDEDE))),
        SizedBox(width: 18),
        Text(
          'OR',
          textAlign: TextAlign.center,
          style: AppTextStyles.semiBold16.copyWith(color: Color(0xFF0C0D0D)),
        ),
        SizedBox(width: 18),
        Expanded(child: Divider(thickness: 1, color: Color(0xFFDCDEDE))),
      ],
    );
  }
}
