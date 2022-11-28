import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:chat_sample/core/routes/routes_manager.dart';
import 'package:chat_sample/firebase/fb_auth_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offNamed(
          FbAuthController().loggedIn
              ? RoutesManager.homeScreen
              : RoutesManager.loginScreen,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app-icon.png',
              height: 150,
              width: 150,
            ),
            RichText(
              text: TextSpan(
                text: 'Chat',
                style: TextStyle(fontSize: 80.sp, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: 'App',
                    style: TextStyle(
                        fontSize: 80.sp, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
