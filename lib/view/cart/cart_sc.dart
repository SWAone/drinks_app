import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/auth/sgin_in.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/controller/swa_stor/cash_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/view/auth/sgin_up2.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class CartSc extends StatelessWidget {
  CartSc({super.key});
  CashController cashController = Get.put(CashController());
  OrderController orderController = Get.put(OrderController());
  HomeController homeController = Get.put(HomeController());
  SginInController sginInController = Get.put(SginInController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFC0D3E4),
        systemNavigationBarDividerColor: AppColor.primaryColor));
    return WillPopScope(
      onWillPop: () {
        return exit(0);
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<CashController>(
            init: CashController(),
            builder: (cashController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppHead(
                      title: 'سلة المتشريات',
                      isTowIcon: true,
                      prefxItem: Text('')),
                  cashController.addToCartLoding
                      ? Center(
                          child: LottieBuilder.asset(
                            'assets/anmtions/home_anmtion/mainLoding.json',
                            width: 25.w,
                            height: 25.h,
                          ),
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: SizedBox(
                      width: 310.w,
                      child: cashController.paskketProducts.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.only(top: 31.h),
                              physics: BouncingScrollPhysics(),
                              itemCount: cashController.paskketProducts.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 10.h,
                                      left: 3.w,
                                      right: 3.w,
                                      top: 0.h),
                                  child: _cartItemBox(
                                      item: cashController
                                          .paskketProducts[index]),
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(child: Text('لم تضف عنصر الى السلة')),
                              ],
                            ),
                    ),
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.only(
                  //           topLeft: Radius.circular(15.sp),
                  //           topRight: Radius.circular(15.sp)),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: Colors.grey.withOpacity(0.5),
                  //             blurRadius: 3),
                  //       ]),
                  //   child: cashController.paskketProducts.isNotEmpty
                  //       ? Padding(
                  //           padding: EdgeInsets.only(
                  //               top: 20.h, left: 23.w, right: 22.w),
                  //           child: !isGeust
                  //               ? Column(
                  //                   children: [
                  //                     _info(
                  //                         title: 'السعر الكلي',
                  //                         value:
                  //                             '${NumberFormat('#,##0', 'en_US').format(double.parse('${cashController.totlprice}'))} د.ع',
                  //                         index: 1),
                  //                     Padding(
                  //                       padding: EdgeInsets.symmetric(
                  //                           horizontal: 20.w),
                  //                       child: Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.center,
                  //                         children: [
                  //                           Row(
                  //                             children: [
                  //                               Text('حليب'),
                  //                               Checkbox(
                  //                                 value: cashController.millk,
                  //                                 onChanged: (value) {
                  //                                   cashController.millk =
                  //                                       value!;
                  //                                   cashController.update();
                  //                                 },
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           Text('  |  '),
                  //                           Row(
                  //                             children: [
                  //                               Text('غاز'),
                  //                               Checkbox(
                  //                                 value: cashController.gas,
                  //                                 onChanged: (value) {
                  //                                   cashController.gas = value!;
                  //                                   cashController.update();
                  //                                 },
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           Text('  |  '),
                  //                           Row(
                  //                             children: [
                  //                               Text('شكر'),
                  //                               Checkbox(
                  //                                 value: cashController.suger,
                  //                                 onChanged: (value) {
                  //                                   cashController.suger =
                  //                                       value!;
                  //                                   cashController.update();
                  //                                 },
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //       left: 20.w,
                  //       right: 20.w,
                  //       bottom: 30.h,
                  //       top: 20.h),
                  //   child: Row(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('كتابة ملاحظة'),
                  //       Container(
                  //           alignment: Alignment.center,
                  //           decoration: BoxDecoration(
                  //               borderRadius:
                  //                   BorderRadius.circular(
                  //                       10.r),
                  //               border: Border.all(
                  //                   color: Colors.grey
                  //                       .withOpacity(0.5))),
                  //           width: 150.w,
                  //           child: Center(
                  //               child: TextFormField(
                  //             controller: cashController
                  //                 .adminSendOrderControler,
                  //             decoration: InputDecoration(
                  //                 isDense: true,
                  //                 contentPadding:
                  //                     EdgeInsets.symmetric(
                  //                         vertical: 8.h,
                  //                         horizontal: 8
                  //                             .w), // تقليل الهوامش الداخلية

                  //                 border: InputBorder.none),
                  //           )))
                  //     ],
                  //   ),
                  // ),
                  //                     // cashController.newOrderLOding
                  //                     //     ? LottieBuilder.asset(
                  //                     //         'assets/anmtions/home_anmtion/mainLoding.json',
                  //                     //         width: 30.w,
                  //                     //         height: 68.h,
                  //                     //       )
                  //                     //     : AppBoton(
                  //                     //         botomPading: 5,
                  //                     //         onTap: () async {
                  //                     //           if (cashController.totlprice >
                  //                     //               0) {
                  //                     //             cashController.newOrder();
                  //                     //           }
                  //                     //         },
                  //                     //       ),
                  //                   ],
                  //                 )
                  //               : AppBoton(
                  //                   onTap: () {
                  //                     Get.offAll(() => SginUp2());
                  //                     isGeust = false;
                  //                   },
                  //                   titel: 'انشئ حسابك لاتمام عملية الشراء'),
                  //         )
                  //       : SizedBox.shrink(),
                  // ),
                  cashController.paskketProducts.isNotEmpty
                      ? cashController.newOrderLOding
                          ? LottieBuilder.asset(
                              'assets/anmtions/home_anmtion/mainLoding.json',
                              width: 30.w,
                              height: 68.h,
                            )
                          : AppBoton(
                              titel: 'التالي',
                              botomPading: 5,
                              onTap: () async {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return GetBuilder<CashController>(
                                        init: CashController(),
                                        builder: (co) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.r)),
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 35.h, bottom: 20.h),
                                                  child: Text(
                                                    'اضف ملاحظاتك',
                                                    style: TextStyle(
                                                        fontSize: 22.w,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                  ),
                                                ),
                                                SizedBox(height: 20.h),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value:
                                                          cashController.suger,
                                                      onChanged: (value) {
                                                        cashController.suger =
                                                            value!;
                                                        cashController.update();
                                                      },
                                                    ),
                                                    Text(
                                                      'شكر',
                                                      style: TextStyle(
                                                          fontSize: 19.w,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: cashController.gas,
                                                      onChanged: (value) {
                                                        cashController.gas =
                                                            value!;
                                                        cashController.update();
                                                      },
                                                    ),
                                                    Text(
                                                      'غاز',
                                                      style: TextStyle(
                                                          fontSize: 19.w,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value:
                                                          cashController.millk,
                                                      onChanged: (value) {
                                                        cashController.millk =
                                                            value!;
                                                        cashController.update();
                                                      },
                                                    ),
                                                    Text(
                                                      'حليب',
                                                      style: TextStyle(
                                                          fontSize: 19.w,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w,
                                                      right: 20.w,
                                                      bottom: 30.h,
                                                      top: 20.h),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5))),
                                                      child: Center(
                                                          child: TextFormField(
                                                        controller: cashController
                                                            .adminSendOrderControler,
                                                        decoration:
                                                            InputDecoration(
                                                                label: Text(
                                                                    'كتابة ملاحظة'),
                                                                isDense: true,
                                                                contentPadding:
                                                                    EdgeInsets.symmetric(
                                                                        vertical:
                                                                            8.h,
                                                                        horizontal: 8
                                                                            .w), // تقليل الهوامش الداخلية

                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                      ))),
                                                ),
                                                AppBoton(
                                                  onTap: () {
                                                    Get.back();
                                                    if (cashController
                                                            .totlprice >
                                                        0) {
                                                      cashController.newOrder();
                                                    }
                                                  },
                                                  titel: 'شراء',
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                );
                              },
                            )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              );
            }),
      )),
    );
  }

  Widget _cartItemBox({required ItemModel item}) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.h),
            width: 320.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.sp),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
                color: Colors.white),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 0.h, right: 90.15),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text(
                                      '${item.title} ',
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  height: 20.h,
                                  width: 100.w,
                                  child: Text(
                                    '${item.price.toString()}',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.h, left: 15.w, bottom: 10.h),
                      child: SizedBox(
                        height: 75.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  cashController.paskketProducts.removeWhere(
                                    (element) => element.id == item.id,
                                  );
                                  List<String> m = [];
                                  for (var element
                                      in cashController.paskketProducts) {
                                    m.add(element.id!);
                                  }
                                  print(m);
                                  box.write('f6', m);
                                  var deletPrice;

                                  deletPrice = item.count * item.price!;
                                  cashController.totlprice -=
                                      deletPrice.toDouble();

                                  cashController.update();
                                },
                                child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                )),
                            Container(
                              margin: EdgeInsets.only(bottom: 2.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.sp)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          if (item.isChckBox) {
                                            item.count++;

                                            cashController.totlprice +=
                                                item.price!;

                                            cashController.update();
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: HexColor('#D9D9D9'),
                                                borderRadius:
                                                    BorderRadius.circular(3.r)),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ))),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 3.h, bottom: 0.h),
                                      child: Text(
                                        '${item.count}',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          if (item.isChckBox) {
                                            if (item.count > 1) {
                                              item.count--;

                                              cashController.totlprice -=
                                                  item.price!;

                                              cashController.update();
                                            } else {}
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                color: HexColor('#D9D9D9'),
                                                borderRadius:
                                                    BorderRadius.circular(3.r)),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 70.w,
                child: Align(
                  alignment: Alignment.topRight,
                  child: CachedNetworkImage(
                    fit: BoxFit.fitHeight,
                    fadeOutDuration: Duration(milliseconds: 0),
                    width: 70.85.w,
                    height: 90.h,
                    imageUrl: "${Api.imgsPath}${item.imags}",
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info({required String title, required value, int index = 0}) {
    return Padding(
      padding: EdgeInsets.only(bottom: index == 1 ? 20 : 5.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(color: HexColor('#8A8A8F'), fontSize: 14.sp),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: 200.w,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: index == 1 ? 0 : 5.h,
          ),
          index == 0
              ? Divider(
                  color: HexColor('#E8E8E8'),
                )
              : SizedBox.square(),
        ],
      ),
    );
  }
}
