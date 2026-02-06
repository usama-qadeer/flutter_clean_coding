import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._();

  // ===== HEADINGS =====
  static TextStyle h1 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 1.28,
  );

  static TextStyle h3 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.30,
  );

  // ===== TITLES =====
  static TextStyle title = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.30,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // ===== BODY =====
  static TextStyle body = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.35,
  );

  // ===== BUTTONS / LABELS =====
  static TextStyle button = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  static TextStyle caption = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );
}
