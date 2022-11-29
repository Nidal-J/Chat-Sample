import 'package:chat_sample/firebase/fb_auth_controller.dart';

String get myID => FbAuthController().currentUser?.uid ?? '0';
String get myEmail => FbAuthController().currentUser?.email ?? '';
String? get myName => FbAuthController().currentUser?.displayName ?? '';
String? get myImage => FbAuthController().currentUser?.photoURL ?? '';

String getMyPeerTyping(String peerId) {
  return peerId == myID ? 'is_peer1_typing' : 'is_peer2_typing';
}
