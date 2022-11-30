class ChatUser {
  late String id;
  String name = 'Chat User';
  late String email;
  String bio = 'Hi! I\'m a new Chat User';
  bool online = false;
  String? image;
  String fcmToken = '';
  String? gender;
  late String password;
  ChatUser();

  ChatUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    bio = json['bio'];
    online = json['online'];
    image = json['image'];
    fcmToken = json['fcm_token'] ?? '';
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['bio'] = bio;
    data['online'] = online;
    data['image'] = image;
    data['fcm_token'] = fcmToken;
    return data;
  }
}
