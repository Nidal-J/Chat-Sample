import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isResetting = false.obs;
}
