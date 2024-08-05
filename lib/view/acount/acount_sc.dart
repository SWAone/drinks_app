import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/setting_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/view/acount/seting_page.dart';
import 'package:prostore/view/auth/sgin_up2.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/dilogg/customdilog.dart';
import 'package:hexcolor/hexcolor.dart';

class AcountSc extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  AcountSc({super.key});
  List<DropdownMenuEntry<dynamic>> languces = [
    DropdownMenuEntry(value: 0, label: 'العربية'),
    DropdownMenuEntry(value: 1, label: 'الكردية'),
    DropdownMenuEntry(value: 2, label: 'الانجليزية'),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFC0D3E4),
        systemNavigationBarDividerColor: AppColor.primaryColor));
    return SafeArea(
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controler) {
              return WillPopScope(
                onWillPop: () {
                  return exit(0);
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: box.read('isGeust') ?? false
                        ? Center(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 300.h),
                                  width: 327.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 9,
                                            offset: Offset(0, 4)),
                                      ]),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.h, bottom: 22.h),
                                        child: Text(
                                          'ليس لديك حساب لادارته ',
                                          style: TextStyle(
                                              color: HexColor('#515151'),
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      AppBoton(
                                        titel: 'انشاء حساب',
                                        onTap: () {
                                          Get.offAll(SginUp2());
                                          isGeust = false;
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            ),
                          )
                        : userInfo.phone != '-1'
                            ? GetBuilder<SetingController>(
                                init: SetingController(),
                                builder: (controler) {
                                  return !isGeust
                                      ? Stack(
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: 90.h,
                                                ),
                                                Text(
                                                  'المعلومات الشخصية',
                                                  style: TextStyle(
                                                      fontSize: 20.sp),
                                                ),
                                                SizedBox(
                                                  height: 30.h,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          13.w,
                                                                      right:
                                                                          13.w),
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            40.h),
                                                                width: double
                                                                    .infinity,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 50
                                                                            .h),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    colors: [
                                                                      Color(
                                                                          0xFFC0D3E4),
                                                                      Color(
                                                                          0xFFD3C6E0),
                                                                      Color(
                                                                          0xFFD3C6E0),
                                                                      Color(
                                                                          0xFFC0D3E4),
                                                                    ],
                                                                    stops: [
                                                                      0.0,
                                                                      0.2,
                                                                      0.5,
                                                                      1.0
                                                                    ],
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          40.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          userInfo
                                                                              .name!,
                                                                          style:
                                                                              TextStyle(fontSize: 20.sp),
                                                                          maxLines:
                                                                              2,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          userInfo
                                                                              .phone
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 15.sp),
                                                                          maxLines:
                                                                              2,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    ),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'الطلبات المحققة ${userInfo.number_of_order}',
                                                                          style:
                                                                              TextStyle(fontSize: 16.sp),
                                                                          maxLines:
                                                                              2,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10.h,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            thaem == 1
                                                                ? Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 60
                                                                              .h),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/theam/Group 33143.png',
                                                                        height:
                                                                            70.h,
                                                                        width:
                                                                            27.w,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : SizedBox
                                                                    .shrink(),
                                                            thaem == 1
                                                                ? Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomLeft,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: 140
                                                                              .h),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/theam/Group 33143.png',
                                                                        height:
                                                                            70.h,
                                                                        width:
                                                                            27.w,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : SizedBox
                                                                    .shrink(),
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              HexColor(
                                                                  '#C0D3E4'),
                                                          radius: 40.r,
                                                          child: Image.asset(
                                                            'assets/acount_icons/user-svgrepo-com.png',
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 327.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.w,
                                                        top: 16.h,
                                                        bottom: 12.h,
                                                        right: 0.w),
                                                    child: SizedBox(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          _infoSetting(
                                                              onTap: () {
                                                                Get.defaultDialog(
                                                                    title: 'سياسة الخصوصية',
                                                                    content: Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Text(
                                                                        'خصوصية العمل  ',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20.sp),
                                                                      ),
                                                                    ));
                                                              },
                                                              url:
                                                                  'assets/order_icon/notebook_fill.png',
                                                              lable:
                                                                  'سياسة الخصوصية'),
                                                          SizedBox(
                                                            height: 6.h,
                                                          ),
                                                          _infoSetting(
                                                              onTap: () {
                                                                showDialog(
                                                                  context: Get
                                                                      .context!,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return CustomDialog(
                                                                      icoImage:
                                                                          'assets/dilog_icon/error.png',
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                        box.remove(
                                                                            'userId');
                                                                        box.remove(
                                                                            'orrderss');
                                                                        box.remove(
                                                                            'loction');

                                                                        Get.offAll(
                                                                            SginUp2());
                                                                        isGeust =
                                                                            false;
                                                                      },
                                                                      btnText:
                                                                          'نعم',
                                                                      style: TextStyle(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          color:
                                                                              Colors.red),
                                                                      title:
                                                                          'تسجيل الخروج',
                                                                      body:
                                                                          'هل انت متاكد',
                                                                    ); // إظهار الدايلوج المخصص
                                                                  },
                                                                );
                                                              },
                                                              url:
                                                                  'assets/acount_icons/Logout.png',
                                                              lable:
                                                                  'تسجيل الخروج'),
                                                          SizedBox(
                                                            height: 6.h,
                                                          ),
                                                          _infoSetting(
                                                              onTap: () {
                                                                showDialog(
                                                                  context: Get
                                                                      .context!,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return CustomDialog(
                                                                      icoImage:
                                                                          'assets/dilog_icon/error.png',
                                                                      onPressed:
                                                                          () async {
                                                                        Get.back();
                                                                        box.remove(
                                                                            'userId');

                                                                        box.remove(
                                                                            'orrderss');
                                                                        Get.offAll(
                                                                            SginUp2());
                                                                        isGeust =
                                                                            false;
                                                                        var ssd =
                                                                            await Api.fetchData(path: '/user/del/${userInfo.id}');
                                                                        print(
                                                                            ssd);
                                                                      },
                                                                      btnText:
                                                                          'حذف الحساب',
                                                                      style: TextStyle(
                                                                          fontSize: 15
                                                                              .sp,
                                                                          color:
                                                                              Colors.red),
                                                                      title:
                                                                          'تحذير !',
                                                                      body:
                                                                          'سيودي هذا الى حذف حسابك بشكل نهائي',
                                                                    ); // إظهار الدايلوج المخصص
                                                                  },
                                                                );
                                                              },
                                                              url:
                                                                  'assets/acount_icons/Close_square.png',
                                                              lable:
                                                                  'حذف الحساب'),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 60.h,
                                                ),
                                                Text('يسو للحول البرمجية'),
                                                Text('جميع الحقوق محفوضة 2024 ')
                                              ],
                                            ),
                                            thaem == 2
                                                ? Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Image.asset(
                                                      'assets/theam/pngwing.com (7) 2.png',
                                                      height: 307.h,
                                                      width: 119.w,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            thaem == 2
                                                ? Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Image.asset(
                                                      'assets/theam/pngwing.com (7) 1.png',
                                                      height: 307.h,
                                                      width: 119.w,
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            thaem == 2
                                                ? Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 50.w),
                                                      child: Image.asset(
                                                        'assets/theam/pngwing.com (7) 3.png',
                                                        height: 90.h,
                                                        width: 150.w,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                            thaem == 2
                                                ? Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 80.w),
                                                      child: Image.asset(
                                                        'assets/theam/pngwing.com (7) 3.png',
                                                        height: 70.h,
                                                        width: 150.w,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        )
                                      : Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 300.h),
                                                width: 327.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          blurRadius: 9,
                                                          offset: Offset(0, 4)),
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 15.h,
                                                          bottom: 22.h),
                                                      child: Text(
                                                        'ليس لديك حساب لادارته ',
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '#515151'),
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                    AppBoton(
                                                      titel: 'انشاء حساب',
                                                      onTap: () {
                                                        Get.offAll(SginUp2());
                                                        isGeust = false;
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30.h,
                                              ),
                                            ],
                                          ),
                                        );
                                })
                            : Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 320.h),
                                      child: LottieBuilder.asset(
                                        'assets/anmtions/home_anmtion/mainLoding.json',
                                        width: 40.w,
                                        height: 40.h,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text('جار تحميل بياناتك ...')
                                  ],
                                ),
                              ),
                  ),
                ),
              );
            }));
  }

  Widget _rowText({
    double topPadeing = 24,
    Widget? Rchildren,
    Widget? Lchildren,
    Widget? childm,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadeing.h),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [Rchildren!, Lchildren!],
      ),
    );
  }

  Widget _infoSetting(
      {String url = 'assets/acount_icons/Location.png',
      String lable = 'العنوان',
      bool isLan = false,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LinearGradient(
            colors: [
              Color(0xFFC0D3E4),
              Color(0xFFD3C6E0),
              Color(0xFFD3C6E0),
              Color(0xFFC0D3E4),
            ],
            stops: [0.0, 0.2, 0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        height: 55.h,
        child: _rowText(
            topPadeing: 0,
            Rchildren: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   ${lable}',
                  style: TextStyle(
                      fontSize: 14.sp, color: Colors.black.withOpacity(0.8)),
                ),
              ],
            ),
            Lchildren: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
              ),
            )),
      ),
    );
  }
}
