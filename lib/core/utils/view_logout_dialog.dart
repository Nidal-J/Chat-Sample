import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';

void viewLogoutDialog(
    {required String message,
    String? content,
    void Function()? onConfirm,
    required BuildContext context}) {
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) {
        if (Platform.isAndroid) {
          return AlertDialog(
            backgroundColor: ColorsManager.bgColor,
            contentPadding: const EdgeInsets.fromLTRB(24, 0, 20, 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                Divider(
                  thickness: 1,
                  endIndent: 140.w,
                  height: 50.h,
                ),
              ],
            ),
            content: Text(content ?? ''),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: ColorsManager.success,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: onConfirm,
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: ColorsManager.danger,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        } else {
          return CupertinoAlertDialog(
            title: Text(message),
            content: Text(content ?? ''),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: ColorsManager.danger,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: onConfirm,
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: ColorsManager.success,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SizedBox(width: 80.w),
            ],
          );
        }
      });
  // Get.defaultDialog(
  //   title: message,
  //   titlePadding: EdgeInsets.only(top: 20.h),
  //   middleText: '',
  //   content: Divider(
  //     thickness: 1,
  //     indent: 100.w,
  //     endIndent: 100.w,
  //   ),
  //   contentPadding: EdgeInsets.zero,
  //   radius: 20.r,
  //   actions: [
  //     TextButton(
  //       onPressed: onConfirm,
  //       child: Text(
  //         'Yes',
  //         style: TextStyle(
  //           color: ColorsManager.green,
  //           fontSize: 32.sp,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //     // SizedBox(width: 80.w),
  //     TextButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       child: Text(
  //         'Cancel',
  //         style: TextStyle(
  //           color: ColorsManager.green,
  //           fontSize: 32.sp,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   ],
  // );
}
