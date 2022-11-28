import 'package:get/get.dart';
import 'package:chat_sample/get/controllers/auth/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
