import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/widgets/loading_widget.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/get/controllers/auth/register_controller.dart';
import 'package:chat_sample/models/chat_user.dart';
import 'package:chat_sample/models/process_response.dart';
import 'package:chat_sample/core/utils/show_snackbar.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Type'),
      ),
      body: Stack(
        children: [
          Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(60.w, 30.h, 60.w, 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Enter new account details'),
                  SizedBox(height: 30.h),
                  TextFieldWidget(
                    controller: controller.nameController,
                    hintText: 'Full Name',
                  ),
                  SizedBox(height: 30.h),
                  TextFieldWidget(
                    controller: controller.emailController,
                    hintText: 'Email',
                    isEmail: true,
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                    () => Column(
                      children: [
                        TextFieldWidget(
                          controller: controller.passwordController,
                          hintText: 'Password',
                          isPassword: true,
                          obscureText: !controller.passwordVisible.value,
                        ),
                        SizedBox(height: 30.h),
                        TextFieldWidget(
                          controller: controller.confirmPasswordController,
                          hintText: 'Confirm Password',
                          isPassword: true,
                          obscureText: !controller.passwordVisible.value,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() => Checkbox(
                            value: controller.passwordVisible.value,
                            onChanged: (value) {
                              controller.passwordVisible(
                                  !controller.passwordVisible.value);
                            },
                          )),
                      const Text('show password'),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  const Text('Gender'),
                  SizedBox(height: 20.h),
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'M',
                            groupValue: controller.gender.value,
                            onChanged: (value) {
                              controller.gender(value!);
                            },
                            title: const Text('Male'),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: 'F',
                            groupValue: controller.gender.value,
                            onChanged: (value) {
                              controller.gender(value!);
                            },
                            title: const Text('Female'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (controller.passwordController.text ==
                          controller.confirmPasswordController.text) {
                        if (controller.formKey.currentState!.validate()) {
                          controller.isRegistering(true);
                          await _performRegister();
                        }
                      } else {
                        showSnackbar(
                          message: 'Passwords do not match! Check again',
                          success: false,
                        );
                      }
                    },
                    label: const Icon(Icons.arrow_right_alt_rounded),
                    icon: Text('create account'.toUpperCase()),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Sign In.',
                          style: TextStyle(fontSize: 26.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isRegistering.value,
              child: const LoadingWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performRegister() async {
    ProcessResponse response = await FbAuthController().createAccount(chatUser);
    controller.isRegistering(false);
    if (response.success) {
      Get.back();
      showSnackbar(message: response.message, duration: 6);
    } else {
      showSnackbar(message: response.message, success: false);
    }
  }

  ChatUser get chatUser {
    ChatUser chatUser = ChatUser();
    chatUser.name = controller.nameController.text;
    chatUser.email = controller.emailController.text;
    chatUser.password = controller.passwordController.text;
    chatUser.gender = controller.gender.value;
    return chatUser;
  }
}
