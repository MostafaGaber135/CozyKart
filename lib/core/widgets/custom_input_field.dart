import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    this.controller,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: AppColors.lightInputFill,
        hintText: hintText,
        hintStyle: AppTextStyles.bold16.copyWith(
          color:
              settingsProvider.isDark
                  ? AppColors.darkInputFill
                  : AppColors.primaryAccent,
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFe5e6e9)),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFe5e6e9)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      style: TextStyle(
        color:
            settingsProvider.isDark
                ? AppColors.darkInputFill
                : AppColors.primaryAccent,
      ),
    );
  }
}
