import 'package:get/get.dart';
import 'package:chat_sample/get/controllers/auth/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}
