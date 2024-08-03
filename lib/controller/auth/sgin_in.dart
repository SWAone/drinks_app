import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prostore/api/api.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/swa_stor/cash_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/user.dart';
import 'package:prostore/nav_bar.dart';
import 'package:prostore/view/acount/seting_page.dart';
import 'package:prostore/widget/dilogg/customdilog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SginInController extends GetxController {
  HomeController homeController = Get.put(HomeController());

  GlobalKey<FormState> keyy = new GlobalKey<FormState>();
  GlobalKey<FormState> key2 = new GlobalKey<FormState>();
  String? name, password, phone, loction;
  bool loding = false;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> sginIn() async {
    navBarController.chingPageIndex(0);

    loding = true;
    update();

    if (keyy.currentState!.validate()) {
      keyy.currentState!.save();

      final Map<String, dynamic> registrationData = {
        "phone": phone,
        "password": password,
        "name": name,
        "birthday": firstTime!.toIso8601String() ?? '',
        "number_of_order": 0,
        "state": loction ?? ''
      };

      try {
        final response = await http.post(
          Uri.parse(Api.apiUrl + '/user'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(registrationData),
        );

        if (response.statusCode == 200) {
          await box.write('isGeust', false);
          print('=================');
          print(response.body);
          box.write('userId', jsonDecode(response.body)['result']['_id']);
          userInfo = User.fromJson(jsonDecode(response.body)['result']);
          print(userInfo.id);
          Get.to(NavBar());
        } else {
          try {
            showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return CustomDialog(
                  onPressed: () {
                    Get.back();
                  },
                  btnText: 'حسنا',
                  style: TextStyle(fontSize: 15.sp, color: Colors.red),
                  title: 'حدث خطا',
                  body: jsonDecode(response.body)['message'] ??
                      jsonDecode(response.body)['result']
                          .toString()
                          .split('for model')[0],
                );
              },
            );
          } catch (e) {
            print(e);
          }
        }
      } catch (er) {
        print('$er');
      }
    }
    loding = false;
    update();
  }

  Future<void> login() async {
    if (key2.currentState!.validate()) {
      key2.currentState!.save();
      loding = true;
      update();

      final Map<String, dynamic> data = {
        "phone": phone,
        "password": password,
      };

      final http.Response response = await http.post(
        Uri.parse(Api.apiUrl + '/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        isGeust = false;
        await box.remove('isGeust');
        update();

        box.write('userId', jsonDecode(response.body)['user']['_id']);
        userInfo = User.fromJson(jsonDecode(response.body)['user']);
        userInfo = await homeController.getUserInfo(
            userId: jsonDecode(response.body)['user']['_id']);
        update();
        Get.to(NavBar());
      } else {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return CustomDialog(
              icoImage: 'assets/dilog_icon/error.png',
              onPressed: () {
                Get.back();
              },
              btnText: 'حسنا',
              style: TextStyle(fontSize: 15.sp, color: Colors.red),
              title: 'حدث خطا',
              body: jsonDecode(response.body)['message'],
            );
          },
        );
      }
    }
    loding = false;
    update();
  }

  DateTime? firstTime = DateTime(0);

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1975),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != firstTime) {
      firstTime = picked;
      print(firstTime!.toIso8601String());
      update();
    }
  }
}
