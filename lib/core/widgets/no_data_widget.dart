import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.message = 'No Data'});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 50.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
