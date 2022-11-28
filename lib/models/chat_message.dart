import 'package:chat_sample/core/utils/my_data.dart';

class ChatMessage {
  late String id;
  late String chatId;
  late String message;
  late String senderId;
  late String receiverId;
  late String sentAt;
  late bool sentByMe;

  ChatMessage();

  ChatMessage.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    message = json['message'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    sentAt = json['sent_at'];
    sentByMe = myID == senderId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chat_id'] = chatId;
    data['message'] = message;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['sent_at'] = sentAt;
    return data;
  }
}
