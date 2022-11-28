import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final passwordVisible = false.obs;
  final isLogging = false.obs;
}
