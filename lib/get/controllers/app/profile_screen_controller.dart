import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:chat_sample/firebase/fb_helper.dart';

class ProfileScreenController extends GetxController with FbHelper {
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isEditedProfile = false.obs;
}
