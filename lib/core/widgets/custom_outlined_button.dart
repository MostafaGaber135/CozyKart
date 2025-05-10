import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/core/utils/app_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.textBtn,
    required this.onPressed,
  });
  final String textBtn;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(400, 48),
        side: BorderSide(color: AppColors.primaryAccent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/google.png'),
          Text(
            textBtn,

            style: AppTextStyles.bold19.copyWith(
              color: AppColors.primaryAccent,
            ),
          ),
        ],
      ),
    );
  }
}
