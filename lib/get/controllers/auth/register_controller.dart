import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final passwordVisible = false.obs;
  final gender = 'M'.obs;

  final isRegistering = false.obs;
}
