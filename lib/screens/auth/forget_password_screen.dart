import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/widgets/loading_widget.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/get/controllers/auth/forget_password_controller.dart';
import 'package:chat_sample/models/process_response.dart';
import 'package:chat_sample/core/utils/show_snackbar.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Form(
        key: controller.formKey,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(60.w, 80.h, 60.w, 30.h),
              child: Column(
                children: [
                  TextFieldWidget(
                    controller: controller.emailController,
                    hintText: 'Email',
                    isEmail: true,
                  ),
                  SizedBox(height: 160.h),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        controller.isResetting(false);
                        await _performReset();
                      }
                    },
                    child: Text('reset password'.toUpperCase()),
                  ),
                  SizedBox(height: 60.h),
                  SizedBox(
                    width: 500.w,
                    child: Text(
                      'Enter your email address to reset the password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.isResetting.value,
                child: const LoadingWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performReset() async {
    ProcessResponse response =
        await FbAuthController().resetPassword(controller.emailController.text);
    controller.isResetting(false);
    showSnackbar(
      message: response.message,
      success: response.success,
    );
    if (response.success) {
      Get.back();
    }
  }
}
