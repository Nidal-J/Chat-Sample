import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown Screen'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40.r),
          child: const Text('Something went wrong, please restart Type App'),
        ),
      ),
    );
  }
}
