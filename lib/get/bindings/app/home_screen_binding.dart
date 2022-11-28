import 'package:get/get.dart';
import 'package:chat_sample/get/controllers/app/home_screen_controller.dart';

class HomeScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
