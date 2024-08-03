import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/controller/swa_stor/cash_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/auth/sgin_up2.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProductFull extends StatelessWidget {
  CashController cashController = Get.put(CashController());
  HomeController homeController = Get.put(HomeController());
  ItemModel item;
  bool isfromFilter;
  ProductFull({super.key, required this.item, this.isfromFilter = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<CashController>(
            init: CashController(),
            builder: (cc) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 26.h, left: 32.w),
                            child: AppHeadIcon(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.sp),
                                      topRight: Radius.circular(20.sp))),
                              width: double.infinity,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          height: 400.h,
                                          width: double.infinity,
                                          child: CachedNetworkImage(
                                            fadeOutDuration:
                                                Duration(milliseconds: 0),
                                            imageUrl:
                                                "${Api.imgsPath}${item.imags}",
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.4),
                                                      blurRadius: 15,
                                                      spreadRadius: -3,
                                                      offset: Offset(0, -13))
                                                ],
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30.sp),
                                                    topRight: Radius.circular(
                                                        30.sp))),
                                            width: double.infinity,
                                            height: 30.h,
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 22.h, right: 26.w, left: 5.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 190.w,
                                                        child: Text(
                                                          item.title!,
                                                          style: TextStyle(
                                                              fontSize: 17.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                          maxLines: 3,
                                                        ),
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        width: 150.w,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.w),
                                                          child: Text(
                                                            '${NumberFormat('#,##0', 'en_US').format(double.parse('${item.price}'))}',
                                                            style: TextStyle(
                                                                fontSize: 17.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  SizedBox(
                                                    width: 190.w,
                                                    child: Text(
                                                      homeController
                                                          .idToCategory(
                                                              id: item
                                                                  .category!),
                                                      style: TextStyle(
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: HexColor(
                                                              '#508A7B')),
                                                      maxLines: 3,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20.h,
                                                left: 33.w,
                                                right: 33.w,
                                                bottom: 11.h),
                                            child: Divider(
                                              color: HexColor('#F3F3F6'),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 40.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'الوصف',
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#515151'),
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                                SizedBox(
                                                  height: 13.h,
                                                ),
                                                Text(
                                                  item.body!,
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#515151'),
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        cashController.adminSendOrderControler.clear();
                        cashController.update();
                        if (!isGeust) {
                          cashController.insertTocash(
                              item.id!,
                              'f6',
                              'product',
                              cashController.ele,
                              cashController.paskketProducts,
                              cashController,
                              item);
                          cashController.update();
                        } else {
                          Get.offAll(() => SginUp2());
                          box.remove('userId');
                          isGeust = false;
                        }
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0.sp),
                                topRight: Radius.circular(0.sp)),
                            color: HexColor('#354369')),
                        child: !isGeust
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      maxLines: 1,
                                      cashController.isLiked(
                                              item.id!, box.read('f6') ?? [])
                                          ? "اتمام الشراء"
                                          : 'اضافة الى السلة',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 4.h),
                                    child: Image.asset(
                                      'assets/product_full_icon/Filled.png',
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: SizedBox(
                                  width: 300.w,
                                  child: Text(
                                    maxLines: 1,
                                    "انشاء حساب لاتمام الشراء",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
