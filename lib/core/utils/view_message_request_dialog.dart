import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/routes/routes_manager.dart';
import 'package:chat_sample/firebase/fb_firestore_chats_controller.dart';
import 'package:chat_sample/firebase/fb_firestore_messages_controller.dart';
import 'package:chat_sample/models/chat.dart';
import 'package:chat_sample/models/chat_user.dart';
import 'package:chat_sample/core/utils/show_snackbar.dart';

void viewMessageRequest(
    {required Chat chat,
    required ChatUser peer,
    required BuildContext context}) {
  showDialog(
    barrierColor: Colors.black.withOpacity(0.8),
    context: context,
    builder: (context) {
      Future<bool> performAccept(String chatId) async {
        return true;
        // return await FbFireStoreChatsController()
        //     .updateChatStatus(ChatStatus.accepted.name, chatId);
      }

      Future<bool> performReject(String chatId) async {
        return true;
        // return await FbFireStoreChatsController()
        //     .updateChatStatus(ChatStatus.rejected.name, chatId);
      }

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
                radius: 100.r,
                child: CircleAvatar(
                  backgroundColor: ColorsManager.white,
                  backgroundImage: peer.image?.isNotEmpty ?? false
                      ? NetworkImage(peer.image!)
                      : const AssetImage('assets/images/avatar.png')
                          as ImageProvider,
                  radius: 150.r,
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: peer.name,
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.success,
                    ),
                    children: [
                      TextSpan(
                        text: ' has sent you',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.white,
                        ),
                      ),
                    ],
                  )),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.forum_rounded,
                          size: 40.r,
                        ),
                      ),
                      TextSpan(
                        text: ' messaging request ',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.white,
                        ),
                      ),
                      WidgetSpan(
                        child: Transform(
                            alignment: AlignmentDirectional.center,
                            transform: Matrix4.rotationY(3.14),
                            child: Icon(
                              Icons.forum_rounded,
                              size: 40.r,
                            )),
                      ),
                    ],
                  )),
              SizedBox(height: 70.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      bool success = await performReject(chat.id);
                      if (success) {
                        // await FbFireStoreMessagesController()
                        //     .deleteRejectedChatMessages(chat.id);
                        // await FbFireStoreChatsController().deleteChat(chat.id);
                      } else {
                        showSnackbar(
                            message: 'Something went wrong!! Try again later.');
                      }
                    },
                    child: const Text('Reject'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await performAccept(chat.id);
                      if (success) {
                        Get.back();
                        // Get.offAndToNamed(
                        //   RoutesManager.chatScreen,
                        //   arguments: {
                        //     'chat': chat,
                        //     'peer': peer,
                        //   },
                        // );
                      } else {
                        showSnackbar(
                            message: 'Something went wrong!! Try again later.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.success,
                      fixedSize: Size(Get.width / 4, 60.h),
                    ),
                    child: const Text('Accept'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
