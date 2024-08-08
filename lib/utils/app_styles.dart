import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyle {
  static TextStyle appBarStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.white);
  static TextStyle titlesTextStyle = TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: AppColors.primary);

  static TextStyle bottomSheetTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.black);

  static TextStyle bodyTextStyle = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.black);

  static TextStyle appBarDarkStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.black);

  static TextStyle unSelectedCalendarDayStyle = TextStyle(
      color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 15);

  static TextStyle selectedCalendarDayStyle =
  unSelectedCalendarDayStyle.copyWith(color: AppColors.primary);
  static const TextStyle normalGreyTextStyle =
  TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500);
}