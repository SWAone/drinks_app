import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/auth/sgin_in.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/view/notfictions.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/app_input.dart';
import 'package:prostore/widget/dilogg/customdilog.dart';

class AppHead extends StatelessWidget {
  HomeController homeController = Get.find();
  SginInController sginCtrl = Get.put(SginInController());
  bool isTowIcon = false;
  bool showsuportIcon = false;

  String title;
  Widget prefxItem;
  bool showAppIcon;

  AppHead(
      {super.key,
      this.showsuportIcon = false,
      this.showAppIcon = true,
      this.isTowIcon = false,
      required this.prefxItem,
      this.title = 'الطلبات'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding:
            EdgeInsets.only(top: 34.h, left: 31.w, right: 31.w, bottom: 0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w900),
            ),
            prefxItem,
          ],
        ),
      ),
    );
  }
}
