import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_sample/models/chat_user.dart';
import 'package:chat_sample/core/utils/my_data.dart';
import 'fb_helper.dart';

class FbFireStoreUsersController with FbHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FbFireStoreUsersController._();
  static FbFireStoreUsersController? _instnace;
  factory FbFireStoreUsersController() {
    return _instnace ??= FbFireStoreUsersController._();
  }

  // Future<bool> saveUser(ChatUser chatUser) async {
  //   return _firestore
  //       .collection("Users")
  //       .doc(chatUser.id)
  //       .set(chatUser.toJson())
  //       .then((value) => true)
  //       .catchError((e) => false);
  // }

  // Future<bool> updateMyOnlineStatus(bool onlineStatus) async {
  //   return await _firestore
  //       .collection("Users")
  //       .doc(myID)
  //       .update({"online": onlineStatus}).then((value) {
  //     return true;
  //   }).catchError((error) => false);
  // }

  // Future<bool> updateMyImage(String imageUrl) async {
  //   return _firestore
  //       .collection("Users")
  //       .doc(myID)
  //       .update({"image": imageUrl})
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }

  // Future<bool> updateFcmToken(String fcmToken) async {
  //   return _firestore
  //       .collection("Users")
  //       .doc(myID)
  //       .update({"fcm_token": fcmToken})
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }

  // Future<bool> updateMyProfile(ChatUser chatUser) async {
  //   await FbAuthController().currentUser?.updateDisplayName(chatUser.name);
  //   return _firestore
  //       .collection("Users")
  //       .doc(myID)
  //       .update({
  //         "name": chatUser.name,
  //         "bio": chatUser.bio,
  //       })
  //       .then((value) => true)
  //       .catchError((error) => false);
  // }

  Stream<QuerySnapshot<ChatUser>> readUsers() async* {
    yield* _firestore
        .collection("Users")
        .where("id", isNotEqualTo: myID)
        .withConverter<ChatUser>(
            fromFirestore: (snapshot, options) =>
                ChatUser.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson())
        .snapshots();
  }

  Stream<QuerySnapshot<ChatUser>> readPeerData(String id) async* {
    yield* _firestore
        .collection("Users")
        .where("id", isEqualTo: id)
        .withConverter<ChatUser>(
            fromFirestore: (snapshot, options) =>
                ChatUser.fromJson(snapshot.data()!),
            toFirestore: (value, options) => value.toJson())
        .snapshots();
  }

  Future<ChatUser?> getPeerDetails(String peerId) async {
    final docRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(peerId)
        .withConverter<ChatUser>(
          fromFirestore: (snapshot, options) =>
              ChatUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    final docSnap = await docRef.get();
    final chatUser = docSnap.data();
    if (chatUser != null) {
      return chatUser;
    } else {
      return null;
    }
  }
}
