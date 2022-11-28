import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/get/controllers/app/home_screen_controller.dart';

class MessageRequestsScreen extends GetView<HomeScreenController> {
  const MessageRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging Requests'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.forum_rounded),
                Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Text(
                    'Messaging requests from other Type Users',
                    style: TextStyle(
                      fontSize: 25.sp,
                    ),
                  ),
                ),
                Transform(
                    alignment: AlignmentDirectional.center,
                    transform: Matrix4.rotationY(3.14),
                    child: const Icon(Icons.forum_rounded)),
              ],
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        horizontalTitleGap: 40.w,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'User Name',
                              style: TextStyle(
                                fontSize: 25.sp,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '3:29 PM',
                                  style: TextStyle(
                                    color: ColorsManager.hintColor,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 22.r,
                                  color: ColorsManager.hintColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: ColorsManager.white,
                          backgroundImage:
                              const AssetImage('assets/images/avatar.png'),
                          radius: 40.r,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await _performAccept('99');
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.green,
                                fixedSize: Size(Get.width / 4, 60.h)),
                            child: const Text('Accept'),
                          ),
                          SizedBox(width: 20.w),
                          OutlinedButton(
                            onPressed: () async {
                              await _performReject('99');
                            },
                            child: const Text('Reject'),
                          ),
                        ],
                      ),
                      const Divider(
                        color: ColorsManager.dividerColor,
                        thickness: 2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _performAccept(String chatId) async {
    return true;
  }

  Future<bool> _performReject(String chatId) async {
    return true;
  }
}
