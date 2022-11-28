import 'package:get/get.dart';
import 'package:chat_sample/get/controllers/app/profile_screen_controller.dart';

class ProfileScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileScreenController());
  }
}
