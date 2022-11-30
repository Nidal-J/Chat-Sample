import 'package:chat_sample/core/widgets/loading_widget.dart';
import 'package:chat_sample/core/widgets/no_data_widget.dart';
import 'package:chat_sample/firebase/fb_firestore_chats_controller.dart';
import 'package:chat_sample/firebase/fb_firestore_users_controller.dart';
import 'package:chat_sample/models/chat_user.dart';
import 'package:chat_sample/screens/app/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              child: StreamBuilder<QuerySnapshot<ChatUser>>(
                  stream: FbFireStoreUsersController().readUsers(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final chatUser =
                                  snapshot.data!.docs[index].data();
                              return InkWell(
                                onTap: () async {
                                  final chat = await FbFireStoreChatsController()
                                      .manageChat(chatUser.id);
                                  Get.to(ChatScreen(chat: chat));
                                },
                                child: ListTile(
                                  minVerticalPadding: 35.h,
                                  horizontalTitleGap: 40.w,
                                  title: Text(
                                    chatUser.name,
                                    style: TextStyle(
                                      fontSize: 26.sp,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text(
                                      chatUser.bio,
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
                                    backgroundImage: chatUser.image != null
                                        ? NetworkImage(chatUser.image!)
                                        : const AssetImage(
                                                'assets/images/avatar.png')
                                            as ImageProvider,
                                    radius: 50.r,
                                  ),
                                ),
                              );
                            },
                          )
                        : snapshot.connectionState == ConnectionState.waiting
                            ? const LoadingWidget()
                            : const NoDataWidget();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
