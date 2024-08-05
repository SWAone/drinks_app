import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../const/app_color.dart';

// http://10.0.2.2:80
class Api {
  static String apiUrl = 'http://194.163.183.145';
  static String imgsPath = '$apiUrl/public/imgs/';

  static fetchData({String path = '', String lableReslut = 'result'}) async {
    try {
      final response = await http.get(Uri.parse('${apiUrl}${path}'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body)[lableReslut];
      } else {
        print('==========================================================');
      }
    } catch (e) {
      Get.defaultDialog(title: 'حدث خطا', content: Text('اعد تشغيل التطبيق'));
    }
  }

  static Future<void> postData(
      {required String path,
      required Map body,
      void Function(dynamic respons)? sucsues,
      void Function(dynamic erorr)? erorr}) async {
    String jsonData = jsonEncode(body);

    try {
      var response = await http.post(
        Uri.parse(apiUrl + path),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        sucsues!(jsonDecode(response.body));
      } else {
        erorr!(jsonDecode(response.body));
      }
    } catch (e) {
      erorr!('erorrrrrrrrrrrrrrr ${e.toString()}');
    }
  }

  Future<void> onDoDialog(
      BuildContext context, String msg, String btnOkay, Function function) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              height: 224.h,
              width: 298.w,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  SizedBox(height: 33.h),
                  Image(
                      image: const AssetImage('assets/icons/notification.png'),
                      width: 10.w,
                      height: 55.h),
                  SizedBox(height: 10.h),
                  Text(
                    msg,
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.sp),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          function();
                        },
                        child: Container(
                          height: 36.h,
                          width: 115.w,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 4,
                                    spreadRadius: 0),
                              ]),
                          child: Center(
                              child: Text(
                            btnOkay,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
