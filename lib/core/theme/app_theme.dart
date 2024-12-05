import 'package:flutter/cupertino.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static const textTheme = CupertinoTextThemeData(
    primaryColor: AppColors.text,
    textStyle: TextStyle(
      color: AppColors.text,
      fontSize: 16,
    ),
    navTitleTextStyle: TextStyle(
      color: AppColors.text,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    navLargeTitleTextStyle: TextStyle(
      color: AppColors.text,
      fontSize: 34,
      fontWeight: FontWeight.bold,
    ),
  );

  static const themeData = CupertinoThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    barBackgroundColor: AppColors.surface,
    textTheme: textTheme,
  );
} 