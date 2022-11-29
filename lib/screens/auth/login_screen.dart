import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/routes/routes_manager.dart';
import 'package:chat_sample/core/widgets/loading_widget.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';
import 'package:chat_sample/get/controllers/auth/login_controller.dart';
import 'package:chat_sample/models/process_response.dart';
import 'package:chat_sample/core/utils/show_snackbar.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Form(
                key: controller.formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(60.w, 30.h, 60.w, 30.h),
                  children: [
                    Image.asset(
                      'assets/images/app-icon.png',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 80.h),
                    TextFieldWidget(
                      controller: controller.emailController,
                      hintText: 'Your Email',
                      isEmail: true,
                    ),
                    SizedBox(height: 40.h),
                    Obx(() => TextFieldWidget(
                          controller: controller.passwordController,
                          hintText: 'Your Password',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          obscureText: !controller.passwordVisible.value,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.passwordVisible(
                                  !controller.passwordVisible.value);
                            },
                            icon: controller.passwordVisible.value
                                ? const Icon(
                                    Icons.visibility,
                                    color: ColorsManager.success,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: ColorsManager.hintColor,
                                  ),
                          ),
                        )),
                    SizedBox(height: 50.h),
                    ElevatedButton(
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          controller.isLogging(true);
                          await _performLogin();
                        }
                      },
                      child: Text('sign in'.toUpperCase()),
                    ),
                    SizedBox(height: 40.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            color: ColorsManager.white,
                            indent: Get.width / 5,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: const Text('OR'),
                        ),
                        Expanded(
                          child: Divider(
                            color: ColorsManager.white,
                            endIndent: Get.width / 5,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.h),
                    ElevatedButton.icon(
                      onPressed: () async {
                        controller.isLogging(true);
                        await _performLoginWithFacebook();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/facebook.png',
                        height: 40.h,
                        width: 70.w,
                      ),
                      label: const Text('Continue with Facebook'),
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton.icon(
                      onPressed: () async {
                        controller.isLogging(true);
                        await _performLoginWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: 40.h,
                        width: 70.w,
                      ),
                      label: const Text('Continue with Google     '),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RoutesManager.forgetPasswordScreen);
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RoutesManager.registerScreen);
                          },
                          child: Text(
                            'Create Account'.toUpperCase(),
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
                visible: controller.isLogging.value,
                child: const LoadingWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performLogin() async {
    ProcessResponse response = await FbAuthController().signInWithEmail(
        email: controller.emailController.text,
        password: controller.passwordController.text);
    controller.isLogging(false);
    showSnackbar(message: response.message, success: response.success);
    if (response.success) {
      Get.offAllNamed(RoutesManager.homeScreen);
    }
  }

  Future<void> _performLoginWithGoogle() async {
    final response = await FbAuthController().signInWithGoogle();
    controller.isLogging(false);
    if (response != null) {
      showSnackbar(
        message: response.message,
        success: response.success,
      );
      if (response.success) {
        Get.offAllNamed(RoutesManager.homeScreen);
      }
    }
  }

  Future<void> _performLoginWithFacebook() async {
    final response = await FbAuthController().signInWithFacebook();
    controller.isLogging(false);
    if (response != null) {
      showSnackbar(
        message: response.message,
        success: response.success,
      );
      if (response.success) {
        Get.offAllNamed(RoutesManager.homeScreen);
      }
    }
  }
}
