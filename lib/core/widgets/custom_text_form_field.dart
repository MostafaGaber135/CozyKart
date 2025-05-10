import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
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
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        fillColor: AppColors.lightInputFill,
        hintText: hintText,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.primaryAccent,
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Color(0xFFe5e6e9)),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
