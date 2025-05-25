import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  static const String _fontFamily = 'Poppins';

  // Extra Small
  static TextStyle regular11 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle semiBold11 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
  );

  // Small
  static TextStyle regular13 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle semiBold13 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bold13 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
  );

  // Medium
  static TextStyle regular15 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle medium15 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regular16 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
  );
  static TextStyle semiBold16 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle bold16 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  // Large
  static TextStyle bold19 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 19.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle regular22 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle regular26 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 26.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bold23 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 23.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bold28 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle bold32 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );
}
