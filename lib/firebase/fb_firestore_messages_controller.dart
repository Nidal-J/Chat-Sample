import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_sample/models/chat_message.dart';
import 'fb_helper.dart';

class FbFireStoreMessagesController with FbHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FbFireStoreMessagesController._();
  static FbFireStoreMessagesController? _instance;
  factory FbFireStoreMessagesController() {
    return _instance ??= FbFireStoreMessagesController._();
  }

  Future<bool> sendMessage(ChatMessage chatMessage) {
    return _firestore
        .collection('ChatMessages')
        .add(chatMessage.toJson())
        .then((value) {
      updateLastMessage(
          lastMessageText: chatMessage.message,
          lastMessageTime: chatMessage.sentAt,
          chatId: chatMessage.chatId);
      return true;
    }).catchError((e) => false);
  }

  Stream<QuerySnapshot<ChatMessage>> fetchMessages(String chatID) async* {
    yield* _firestore
        .collection('ChatMessages')
        .where('chat_id', isEqualTo: chatID)
        .orderBy('sent_at', descending: true)
        .withConverter<ChatMessage>(
          fromFirestore: (snapshot, options) =>
              ChatMessage.fromJson(snapshot.data()!),
          toFirestore: (chatMessage, options) => chatMessage.toJson(),
        )
        .snapshots();
  }

  // Stream<QuerySnapshot<ChatMessage>> fetchChatMessages(String chatId) async* {
  //   yield* _firestore
  //       .collection("ChatMessages")
  //       .where("chat_id", whereIn: [chatId])
  //       .orderBy('sent_at', descending: true)
  //       .withConverter<ChatMessage>(
  //         fromFirestore: (snapshot, options) =>
  //             ChatMessage.fromJson(snapshot.data()!),
  //         toFirestore: (value, options) => value.toJson(),
  //       )
  //       .snapshots();
  // }

  // Future<bool> sendMessage(ChatMessage chatMessage) async {
  //   return _firestore
  //       .collection("ChatMessages")
  //       .add(chatMessage.toJson())
  //       .then((value) {
  //     updateLastMessage(
  //       lastMessageText: chatMessage.message,
  //       lastMessageTime: chatMessage.sentAt,
  //       chatId: chatMessage.chatId,
  //     );
  //     return true;
  //   }).catchError((error) {
  //     return false;
  //   });
  // }

  // Future<void> deleteRejectedChatMessages(String chatId) async {
  //   QuerySnapshot result = await _firestore
  //       .collection("ChatMessages")
  //       .where('chat_id', isEqualTo: chatId)
  //       .get();
  //   for (var element in result.docs) {
  //     element.reference.delete();
  //   }
  // }

  Future<bool> updateLastMessage(
      {required String lastMessageText,
      required String lastMessageTime,
      required String chatId}) async {
    return _firestore
        .collection("Chats")
        .doc(chatId)
        .update({
          "last_message_text": lastMessageText,
          "last_message_time": lastMessageTime,
        })
        .then((value) => true)
        .catchError((error) => false);
  }
}
