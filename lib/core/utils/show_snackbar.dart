import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';

void showSnackbar({
  String? title,
  required String message,
  bool success = true,
  int duration = 3,
}) {
  Get.showSnackbar(
    GetSnackBar(
      title: title,
      backgroundColor: success ? ColorsManager.success : ColorsManager.danger,
      message: message,
      duration: Duration(seconds: duration),
    ),
  );
}
