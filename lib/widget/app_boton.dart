import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/view/order/check_out.dart';
import 'package:hexcolor/hexcolor.dart';

class AppBoton extends StatelessWidget {
  String titel;
  double botomPading = 20;
  void Function()? onTap;
  AppBoton(
      {super.key,
      this.titel = 'اتمام عملية الشراء',
      this.onTap,
      this.botomPading = 20});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: botomPading.h),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: HexColor('#354369'),
                borderRadius: BorderRadius.circular(24.sp)),
            width: 315.w,
            height: 48.h,
            child: Center(
                child: Container(
              alignment: Alignment.center,
              width: 300.w,
              child: Text(
                titel,
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
