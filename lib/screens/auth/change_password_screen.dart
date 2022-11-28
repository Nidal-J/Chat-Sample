import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/get/controllers/auth/change_password_controller.dart';
import 'package:chat_sample/models/process_response.dart';
import 'package:chat_sample/core/utils/show_snackbar.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(60.w, 30.h, 60.w, 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 500.w,
                      child: Text(
                        'Create a new  password for your account',
                        style: TextStyle(
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    TextFieldWidget(
                      controller: controller.newPasswordController,
                      hintText: 'New Password',
                      isPassword: true,
                      obscureText: !controller.newPasswordVisible.value,
                    ),
                    SizedBox(height: 30.h),
                    TextFieldWidget(
                      controller: controller.confirmNewPasswordController,
                      hintText: 'Confirm New Password',
                      isPassword: true,
                      obscureText: !controller.newPasswordVisible.value,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => Checkbox(
                        value: controller.newPasswordVisible.value,
                        onChanged: (value) {
                          controller.newPasswordVisible(
                              !controller.newPasswordVisible.value);
                        },
                      )),
                  const Text('show password'),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (controller.newPasswordController.text ==
                      controller.confirmNewPasswordController.text) {
                    if (controller.formKey.currentState!.validate()) {
                      controller.isChanging(true);
                      await _performChangePasswor();
                    }
                  } else {
                    showSnackbar(
                      message: 'Passwords do not match! Check again',
                      success: false,
                    );
                  }
                },
                child: Text('update password'.toUpperCase()),
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performChangePasswor() async {
    ProcessResponse response = await FbAuthController()
        .changePassword(controller.newPasswordController.text);
    controller.isChanging(false);
    Get.back();
    showSnackbar(
      message: response.message,
      success: response.success,
    );
  }
}
