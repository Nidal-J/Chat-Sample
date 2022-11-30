import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_sample/models/chat.dart';
import 'package:chat_sample/core/utils/my_data.dart';
import 'fb_helper.dart';

class FbFireStoreChatsController with FbHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FbFireStoreChatsController._();
  static FbFireStoreChatsController? _instance;
  factory FbFireStoreChatsController() {
    return _instance ??= FbFireStoreChatsController._();
  }

  Stream<QuerySnapshot<Chat>> fetchChats(String chatStatus) async* {
    yield* _firestore
        .collection("Chats")
        .where("peers", arrayContainsAny: [myID])
        .where("chat_status", isEqualTo: chatStatus)
        .orderBy('last_message_time', descending: true)
        .withConverter<Chat>(
          fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<Chat>> fetchChat(String chatId) async* {
    yield* _firestore
        .collection("Chats")
        .where("id", isEqualTo: chatId)
        .withConverter<Chat>(
          fromFirestore: (snapshot, options) => Chat.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .snapshots();
  }
  
  Future<Chat> manageChat(String peerId) async {
    Chat? chat = await _isChatExisted(peerId);
    if (chat != null) {
      return chat;
    } else {
      return await _createChat(peerId);
    }
  }

  Future<Chat?> _isChatExisted(String peerId) async {
    final chatRef = _firestore.collection('Chats');
    final mapQuery = chatRef.where("peers", whereIn: [
      [peerId, myID],
      [myID, peerId]
    ]);
    final chatQuery = await mapQuery
        .withConverter<Chat>(
            fromFirestore: (snapshot, options) =>
                Chat.fromJson(snapshot.data()!),
            toFirestore: (Chat chat, options) => chat.toJson())
        .get();
    if (chatQuery.docs.isNotEmpty) {
      var document = chatQuery.docs.first;
      Chat chat = document.data();
      chat.id = document.id;
      return chat;
    }
    return null;
  }

  Future<Chat> _createChat(String peerId) async {
    Chat chat = _generateNewChat(peerId);
    final chatRef = _firestore.collection("Chats").doc();
    log('New Chat Created Path: $chatRef');
    chat.id = chatRef.id;
    chatRef.set(chat.toJson());
    return chat;
  }

  Chat _generateNewChat(String peerId) {
    Chat chat = Chat();
    chat.peers = [myID, peerId];
    chat.createdBy = myID;
    chat.chatStatus = ChatStatus.waiting.name;
    return chat;
  }

  Future<void> deleteChat(String chatId) async {
    await _firestore.collection("Chats").doc(chatId).delete();
  }

  Future<bool> updateChatStatus(String chatStatus, String chatId) async {
    return _firestore
        .collection("Chats")
        .doc(chatId)
        .update({"chat_status": chatStatus})
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateMyTypingStatus(
      {required bool isTyping,
      required String chatId,
      required String myPeer}) async {
    return _firestore
        .collection("Chats")
        .doc(chatId)
        .update({myPeer: isTyping})
        .then((value) => true)
        .catchError((error) => false);
  }
}
