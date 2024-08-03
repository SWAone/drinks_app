import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppHeadIcon extends StatelessWidget {
  String iconUrl;
  double? w, h;
  void Function()? action;
  AppHeadIcon({
    this.h = 32,
    this.w = 32,
    super.key,
    this.iconUrl = 'assets/product_full_icon/back.png',
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
        if (action != null) {
          action!();
        }
      },
      child: Container(
        width: w!.w,
        height: h!.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 3)
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: Center(
            child: Image.asset(iconUrl),
          ),
        ),
      ),
    );
  }
}
