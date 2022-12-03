import 'dart:developer';

import 'package:chat_sample/core/utils/my_data.dart';
import 'package:chat_sample/core/utils/time_date_send.dart';
import 'package:chat_sample/core/widgets/loading_widget.dart';
import 'package:chat_sample/core/widgets/no_data_widget.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/firebase/fb_firestore_messages_controller.dart';
import 'package:chat_sample/firebase/fb_firestore_users_controller.dart';
import 'package:chat_sample/models/chat.dart';
import 'package:chat_sample/models/chat_message.dart';
import 'package:chat_sample/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/widgets/message_card.dart';
import 'package:chat_sample/core/widgets/typing_indicator.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.chat}) : super(key: key);
  final Chat chat;

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

  // List<bool> isMe = [true, false, false, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: StreamBuilder<QuerySnapshot<ChatUser>>(
            stream: FbFireStoreUsersController()
                .readPeerData(widget.chat.getPeerId()),
            builder: (context, snapshot) {
              final chatUser =
                  snapshot.hasData ? snapshot.data!.docs.first.data() : null;
              return snapshot.hasData
                  ? ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 40.r,
                        backgroundColor: ColorsManager.white,
                        backgroundImage: chatUser!.image != null
                            ? NetworkImage(chatUser.image!)
                            : const AssetImage('assets/images/avatar.png')
                                as ImageProvider,
                      ),
                      title: Text(chatUser.name),
                      subtitle: Text(
                        chatUser.online ? 'online' : 'offline',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: chatUser.online
                              ? ColorsManager.success
                              : ColorsManager.grey,
                        ),
                      ),
                    )
                  : Container();
            }),
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
                child: StreamBuilder<QuerySnapshot<ChatMessage>>(
                    stream: FbFireStoreMessagesController()
                        .fetchMessages(widget.chat.id),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final chatMessage =
                                    snapshot.data!.docs[index].data();
                                return Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(top: 20.h),
                                  child: Row(
                                    mainAxisAlignment: chatMessage.sentByMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      MessageCard(
                                        isMe: chatMessage.sentByMe,
                                        message: chatMessage.message,
                                        time: timeSend(chatMessage.sentAt),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : snapshot.connectionState == ConnectionState.waiting
                              ? const LoadingWidget()
                              : const NoDataWidget();
                    })),
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
    if (_checkData()) {
      log('message 1');
      await FbFireStoreMessagesController().sendMessage(message);
      log('message 2');
    }
  }

  ChatMessage get message {
    ChatMessage chatMessage = ChatMessage();
    chatMessage.message = messageController.text;
    messageController.clear();
    chatMessage.senderId = myID;
    chatMessage.sentByMe = true;
    chatMessage.receiverId = widget.chat.getPeerId();
    chatMessage.sentAt = DateTime.now().millisecondsSinceEpoch.toString();
    chatMessage.chatId = widget.chat.id;
    return chatMessage;
  }
}
