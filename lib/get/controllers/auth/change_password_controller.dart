import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final oldPasswordVisible = false.obs;
  final newPasswordVisible = false.obs;
  final isChanging = false.obs;
}
