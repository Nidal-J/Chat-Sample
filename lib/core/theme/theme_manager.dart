import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';

class ThemeManager {
  static ThemeData dark() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: ColorsManager.scaffoldBg,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Get.width, 100.h),
          textStyle: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: ColorsManager.purble,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          fixedSize: Size(Get.width / 4, 60.h),
          foregroundColor: ColorsManager.danger,
          side: const BorderSide(
            color: ColorsManager.danger,
            width: 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(
            // fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          foregroundColor: ColorsManager.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 30.sp,
          fontWeight: FontWeight.w500,
          color: ColorsManager.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyText2: TextStyle(
          color: ColorsManager.white,
          fontWeight: FontWeight.w500,
          fontSize: 28.sp,
        ),
      ),
    );
  }
}
