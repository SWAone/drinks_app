import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/auth/sgin_in.dart';
import 'package:prostore/main.dart';
import 'package:prostore/nav_bar.dart';
import 'package:prostore/view/auth/login2.dart';
import 'package:prostore/view/auth/sgin_up2.dart';
import 'package:prostore/widget/app_input.dart';
import 'package:hexcolor/hexcolor.dart';

class RootAuth extends StatelessWidget {
  const RootAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC0D3E4),
      body: GetBuilder<SginInController>(
          init: SginInController(),
          builder: (sginCtrl) {
            return Container(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/acount_icons/photo_2024-08-05_14-03-44.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter, child: FadeContainer())
                ],
              ),
            );
          }),
    );
  }
}

class FadeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopFadeClipper(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x00C0D3E4), // لون أزرق فاتح شفاف
              Color(0xFFC0D3E4), // لون أزرق فاتح
              Color(0xFFD3C6E0), // لون أرجواني فاتح
              Color(0xFFD3C6E0), // لون أرجواني فاتح
              Color(0xFFC0D3E4), // لون أزرق فاتح
              Color(0x00C0D3E4), // لون أزرق فاتح شفاف
            ],
            stops: [0.0, 0.3, 0.45, 0.55, 0.7, 1.0], // نقاط التحكم بالتلاشي
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 60.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(''),
              Text(''),
              Text(''),
              Text(''),
              Container(
                margin: EdgeInsets.only(top: 30.h),
                child: Text(
                  'ستجـد هنـا مشـروبـاتك المُـفضـلـة وكُـــــــل مــا هــو لـــذيذ !',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: HexColor('#354369'),
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                'ماذا تنتظر قم ب',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: HexColor('#354369'),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 44.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SginUp2());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor('#354369'),
                      borderRadius: BorderRadius.circular(26.5.sp)),
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            'انشاء الحساب',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => Login2());
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor('#354369'),
                      borderRadius: BorderRadius.circular(26.sp)),
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () async {
                  await box.write('isSkipLogin', true);

                  Get.to(NavBar());
                },
                child: Container(
                  decoration: BoxDecoration(
                      // color: HexColor('#354369'),
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(26.5.sp)),
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Text(
                            'تخطي',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor),
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopFadeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
