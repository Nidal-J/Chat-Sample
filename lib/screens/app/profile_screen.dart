import 'package:chat_sample/get/controllers/app/profile_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';
import 'package:chat_sample/core/widgets/text_field_widget.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Align(
        alignment: const Alignment(1, -0.5),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(40.w, 0.h, 40.w, 30.h),
          children: [
            Center(
              child: Stack(
                alignment: const Alignment(2, 2),
                children: [
                  Container(
                    height: 170.r,
                    width: 170.r,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: ColorsManager.white,
                    ),
                    child: Image.asset(
                      'assets/images/avatar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: CircleAvatar(
                        backgroundColor: ColorsManager.purble,
                        radius: 30.r,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 30.r,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.h),
            TextButton.icon(
              style: TextButton.styleFrom(
                alignment: AlignmentDirectional.bottomEnd,
              ),
              onPressed: () {
                if (!controller.isEditedProfile.value) {
                  controller.isEditedProfile(!controller.isEditedProfile.value);
                }
              },
              icon: const Icon(
                Icons.edit_rounded,
                color: ColorsManager.purble,
              ),
              label: const Text(
                'Edit',
                style: TextStyle(
                  color: ColorsManager.purble,
                ),
              ),
            ),
            Obx(
              () => IgnorePointer(
                ignoring: !controller.isEditedProfile.value,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: controller.nameController,
                        hintText: 'Your Name',
                      ),
                      SizedBox(height: 20.h),
                      TextFieldWidget(
                        controller: controller.bioController,
                        hintText: 'Hi! I\'m a new Type User',
                        maxLines: 3,
                        minLines: 3,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.formKey.currentState!.validate()) {
                  await _performUpdateProfile();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.purble,
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _performUpdateProfile() async {}
}
