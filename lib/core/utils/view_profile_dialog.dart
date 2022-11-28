import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/models/chat_user.dart';

void viewProfile({required ChatUser partner, required BuildContext context}) {
  showDialog(
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: ColorsManager.bgColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 70.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.shimmerBaseColor,
                radius: 155.r,
                child: CircleAvatar(
                  backgroundColor: ColorsManager.white,
                  backgroundImage: partner.image?.isNotEmpty ?? false
                      ? NetworkImage(partner.image!)
                      : const AssetImage('assets/images/avatar.png')
                          as ImageProvider,
                  radius: 150.r,
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              Text(
                partner.name,
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                partner.email,
                style: const TextStyle(
                  color: Colors.white70,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                partner.bio,
                style: const TextStyle(
                  color: Colors.white70,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50.h),
              ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width * 0.35, 80.h)),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                label: const Text('Get Back'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
