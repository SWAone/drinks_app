import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/widget/app_boton.dart';

class MyDilog {
  static void showMyDialog(
      {String title = 'title',
      void Function()? ok,
      void Function()? notOk,
      String body = 'body',
      TextStyle? titleStyle,
      TextStyle? bodyStyle}) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return myAlertDialog(
            ok: ok,
            notOk: notOk,
            body: body,
            bodyStyle: bodyStyle,
            title: title,
            titleStyle: titleStyle);
      },
    );
  }

  // دالة لإنشاء مربع الحوار
  static Widget myAlertDialog(
      {String title = 'title',
      void Function()? ok,
      void Function()? notOk,
      String body = 'body',
      TextStyle? titleStyle,
      TextStyle? bodyStyle}) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Column(
        children: [
          // Container(
          //   width: 200.w,
          //   height: 100.h,
          //   color: Colors.red,
          //   child: Icon(
          //     Icons.info,
          //     size: 50.0,
          //     color: Colors.blue,
          //   ),
          // ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Text(
        body,
        style: bodyStyle,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100.w,
              child: ElevatedButton(
                onPressed: ok,
                child: Text(
                  'حسنا',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColor.primaryColor.withOpacity(0.9))),
              ),
            ),
            SizedBox(
              width: 100.w,
              child: ElevatedButton(
                onPressed: notOk,
                child: Text(
                  'الغاء',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => AppColor.secondColor)),
              ),
            )
          ],
        )
      ],
    );
  }
}
