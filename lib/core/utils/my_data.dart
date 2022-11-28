import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/models/chat_user.dart';

String get myID {
  // log('------- MY ID--------');
  // log(FbAuthController().currentUser.uid);
  // log('---------------------');
  return FbAuthController().currentUser?.uid ?? '0';
}

ChatUser getPartner(ChatUser peer1, ChatUser peer2) {
  return peer1.id == myID ? peer2 : peer1;
}

String getMyPeer(String peerId) {
  return peerId == myID ? 'is_peer1_typing' : 'is_peer2_typing';
}

// ChatUser getMyData() {
//   ChatUser myData = ChatUser();
//   myData.id = myID;
//   myData.name = myName ?? 'Type User';
//   myData.email = myEmail;
//   myData.
//   return myData;
// }

String get myEmail => FbAuthController().currentUser?.email ?? '';
String? get myName => FbAuthController().currentUser?.displayName ?? '';
String? get myImage => FbAuthController().currentUser?.photoURL ?? '';
