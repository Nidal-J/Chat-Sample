import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/widgets/message_card.dart';
import 'package:chat_sample/core/widgets/typing_indicator.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  StreamController<String> streamController = StreamController();
  final TextEditingController messageController = TextEditingController();
  // final Chat chat = Get.arguments['chat'];
  // final ChatUser peer = Get.arguments['peer'];
  // final String myPeer = getMyPeer(Get.arguments['chat'].createdBy);

  // final String myPeer =
  //     getMyPeer(Get.arguments['chat'].peer1.id, Get.arguments['chat'].peer2.id);

  // @override
  // void initState() {
  //   super.initState();
  //   streamController.stream.debounce(const Duration(seconds: 3)).listen((s) {
  //     FbFireStoreChatsController().updateMyTypingStatus(
  //         isTyping: false, chatId: chat.id, myPeer: myPeer);
  //   });
  // }

  @override
  void dispose() {
    messageController.dispose;
    super.dispose();
  }

  List<bool> isMe = [true, false, false, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: ListTile(
          leading: CircleAvatar(
            radius: 40.r,
            backgroundColor: ColorsManager.white,
            backgroundImage: const AssetImage('assets/images/avatar.png'),
          ),
          title: const Text('User Name'),
          subtitle: Text(
            'typing ...',
            style: TextStyle(
              fontSize: 20.sp,
              color: ColorsManager.green,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: ColorsManager.purble,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            onSelected: (value) {},
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'view_profile',
                  child: Text('View user profile'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40.w, 0.h, 40.w, 30.h),
        child: Column(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsetsDirectional.only(top: 20.h),
                        child: Row(
                          mainAxisAlignment: isMe[index]
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            MessageCard(
                              isMe: isMe[index],
                              message: 'Message Content',
                              date: '3:55 AM',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const TypingIndicator(
                  showIndicator: true,
                ),
              ],
            )),
            Divider(
              color: ColorsManager.dividerColor,
              thickness: 2,
              height: 40.h,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    controller: messageController,
                    hintText: 'Type a message...',
                    isChatField: true,
                    textInputAction: TextInputAction.send,
                    onChange: (value) {},
                  ),
                ),
                SizedBox(width: 10.w),
                IconButton(
                  onPressed: () {
                    _performSendMessage();
                  },
                  icon: Icon(
                    Icons.send_rounded,
                    size: 60.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _checkData() {
    return messageController.text.trim().isNotEmpty;
  }

  void _performSendMessage() async {
    if (_checkData()) {}
  }
}
