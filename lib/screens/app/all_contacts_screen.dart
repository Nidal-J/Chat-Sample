import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/routes/routes_manager.dart';
import 'package:chat_sample/screens/core/search_users_screen.dart';

class AllContactsScreen extends StatelessWidget {
  const AllContactsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Contact'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUsersScreen());
            },
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.w, 0.h, 40.w, 30.h),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.people_alt_rounded,
                size: 42.r,
              ),
              horizontalTitleGap: 0,
              title: Text(
                'All contacts in Type',
                style: TextStyle(
                  fontSize: 25.sp,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      // Chat chat = await FbFireStoreChatsController()
                      //     .manageChat(peer.id);
                      // if (chat.chatStatus == ChatStatus.waiting.name &&
                      //     chat.createdBy != myID) {
                      //   viewMessageRequest(
                      //       chat: chat, peer: peer, context: context);
                      // } else {
                      //   Get.toNamed(
                      //     RoutesManager.chatScreen,
                      //     arguments: {
                      //       'chat': chat,
                      //       'peer': peer,
                      //     },
                      //   );
                      // }
                      Get.toNamed(RoutesManager.chatScreen);
                    },
                    child: ListTile(
                      minVerticalPadding: 35.h,
                      horizontalTitleGap: 40.w,
                      title: Text(
                        'User Name',
                        style: TextStyle(
                          fontSize: 26.sp,
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Text(
                          'User Bio',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 22.sp,
                            color: ColorsManager.hintColor,
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: ColorsManager.white,
                        backgroundImage:
                            const AssetImage('assets/images/avatar.png'),
                        radius: 50.r,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
