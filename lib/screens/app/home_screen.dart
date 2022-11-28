import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/routes/routes_manager.dart';
import 'package:chat_sample/core/widgets/loading_widget.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/get/controllers/app/home_screen_controller.dart';
import 'package:chat_sample/core/utils/my_data.dart';
import 'package:chat_sample/core/utils/show_snackbar.dart';
import 'package:chat_sample/core/utils/view_logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:chat_sample/screens/core/search_users_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Chats'),
            actions: [
              IconButton(
                onPressed: () async {
                  showSearch(context: context, delegate: SearchUsersScreen());
                },
                icon: const Icon(Icons.search_rounded),
              ),
            ],
          ),
          drawer: SafeArea(
            child: Drawer(
              backgroundColor: ColorsManager.bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.horizontal(
                    end: Radius.circular(80.sp)),
              ),
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(myName ?? ''),
                    accountEmail: Text(myEmail),
                    currentAccountPicture: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: ColorsManager.white,
                    ),
                    decoration: const BoxDecoration(
                      color: ColorsManager.purble,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutesManager.profileScreen);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.manage_accounts_rounded),
                      title: Text('My Profile'),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: InkWell(
                      onTap: () async {
                        Get.toNamed(RoutesManager.changePasswordScreen);
                      },
                      child: const ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Change Password'),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Get.toNamed(RoutesManager.messageRequestsScreen);
                    },
                    child: ListTile(
                        leading: const Icon(Icons.forum_rounded),
                        title: const Text('Messaging Requests'),
                        trailing: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: ColorsManager.green,
                          foregroundColor: ColorsManager.white,
                          child: const Text('4'),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      viewLogoutDialog(
                          context: context,
                          message: 'Are you sure?',
                          content: 'You are about to log out.',
                          onConfirm: () async {
                            Get.back();
                            controller.isLoggingOut(true);
                            await _performLogout();
                          });
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 30.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              gradient: const LinearGradient(
                colors: ColorsManager.purbleGradient,
              ),
            ),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                Get.toNamed(RoutesManager.allContactsScreen);
              },
              child: const Icon(
                Icons.chat_rounded,
                color: ColorsManager.white,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40.w, 30.h, 0, 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Frequent contacts',
                  style: TextStyle(
                    color: ColorsManager.hintColor,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 160.h,
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.only(end: 40.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          Get.toNamed(RoutesManager.chatScreen);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 50.r,
                                  backgroundColor: ColorsManager.white,
                                  backgroundImage: const AssetImage(
                                      'assets/images/avatar.png'),
                                ),
                                CircleAvatar(
                                  backgroundColor: ColorsManager.green,
                                  radius: 12.r,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 130.w,
                              child: Text(
                                'User Name',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 25.w),
                  ),
                ),
                SizedBox(height: 50.h),
                Text(
                  'Recent conversations',
                  style: TextStyle(
                    color: ColorsManager.hintColor,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsetsDirectional.only(end: 40.w),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              Get.toNamed(RoutesManager.chatScreen);
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              minVerticalPadding: 40.h,
                              horizontalTitleGap: 40.w,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        '4:35 PM',
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
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Text(
                                  'Last Message Text',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: ColorsManager.hintColor,
                                  ),
                                ),
                              ),
                              leading: InkWell(
                                onTap: () {},
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: ColorsManager.white,
                                      backgroundImage: const AssetImage(
                                          'assets/images/avatar.png'),
                                      radius: 50.r,
                                    ),
                                    CircleAvatar(
                                      backgroundColor: ColorsManager.green,
                                      radius: 12.r,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
        ),
        Obx(() => Visibility(
              visible: controller.isLoggingOut.value,
              child: const LoadingWidget(),
            )),
      ],
    );
  }

  Future<void> _performLogout() async {
    await FbAuthController().signOut();
    controller.isLoggingOut(false);
    Get.offAllNamed(RoutesManager.loginScreen);
    showSnackbar(message: 'Logged out successfully');
  }
}