import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prostore/api/api.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/swa_stor/cash_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/user.dart';
import 'package:prostore/nav_bar.dart';
import 'package:prostore/widget/dilog/alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetingController extends GetxController {
  HomeController homeController = Get.put(HomeController());

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController loction = TextEditingController();
  bool isLodingEdit = false;
  @override
  void onInit() {
    name.text = userInfo!.name.toString();
    phone.text = userInfo!.phone.toString();

    super.onInit();
  }

  Future<void> updateUser(String userId) async {
    isLodingEdit = true;
    update();
    final String apiUrl = '${Api.apiUrl}/auth/$userId';

    Map<String, dynamic> requestBody = {
      'name': name.text,
      'phone': phone.text,
      "loction": loction.text
    };

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        box.write('isFindLoction', true);
        isLodingEdit = false;
        update();
        MyDilog.showMyDialog(
            notOk: () {
              Get.back();
            },
            ok: () {
              Get.back();
            },
            title: 'نجح',
            titleStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
            body: 'تم تحديث المعلومات',
            bodyStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w100));
        homeController.getUserInfo(userId: await box.read('userId'));

        update();
      } else if (response.statusCode == 404) {
        isLodingEdit = false;

        MyDilog.showMyDialog(
            notOk: () {
              Get.back();
            },
            ok: () {
              Get.back();
            },
            title: 'خطا',
            titleStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
            body: jsonDecode(response.body)['result'],
            bodyStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w100));
      } else {
        isLodingEdit = false;

        MyDilog.showMyDialog(
            notOk: () {
              Get.back();
              isLodingEdit = false;
              update();
            },
            ok: () {
              Get.back();
              isLodingEdit = false;
              update();
            },
            title: 'خطا',
            titleStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
            body: jsonDecode(response.body)['result'],
            bodyStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w100));
      }
    } catch (e) {
      isLodingEdit = false;
      update();
      print('حدث خطأ غير متوقع: $e');
    }
  }
}
