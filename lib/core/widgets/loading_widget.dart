import 'package:flutter/material.dart';
import 'package:chat_sample/core/constants/colors_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.2),
      child: const CircularProgressIndicator(
        color: ColorsManager.white,
      ),
    );
  }
}
