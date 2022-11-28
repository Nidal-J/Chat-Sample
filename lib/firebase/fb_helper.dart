import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_sample/models/process_response.dart';

mixin FbHelper {
  ProcessResponse get failureResponse {
    FbAuthController().signOut();
    return ProcessResponse("Something went wrong!! try again later.", false);
  }

  ProcessResponse getAuthExceptionResponse(FirebaseAuthException e) {
    FbAuthController().signOut();
    return ProcessResponse(e.message ?? "", false);
  }
}
