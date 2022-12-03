import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.isMe,
    required this.message,
    required this.time,
  }) : super(key: key);
  final bool isMe;
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.6,
            minWidth: Get.width * 0.2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: isMe ? Radius.zero : Radius.circular(40.r),
              bottomStart: isMe ? Radius.circular(40.r) : Radius.zero,
              topStart: Radius.circular(40.r),
              topEnd: Radius.circular(40.r),
            ),
            gradient: LinearGradient(
              colors: isMe
                  ? ColorsManager.greenGradient
                  : ColorsManager.purbleGradient,
            ),
          ),
          padding: EdgeInsetsDirectional.fromSTEB(30.w, 15.h, 25.w, 25.w),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 26.sp,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white60,
              ),
            ),
            Visibility(
              visible: isMe,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 5.w),
                child: Icon(
                  Icons.done_all,
                  size: 24.r,
                  color: Colors.white60,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
