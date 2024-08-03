import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/order_model.dart';
import 'package:prostore/nav_bar.dart';
import 'package:prostore/view/order/my_orders.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class OrderDetelis extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());
  Order order;
  OrderDetelis({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<OrderController>(
            init: OrderController(),
            builder: (orderController) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        AppHead(
                          showAppIcon: false,
                          title: 'تفاصيل الطلب',
                          prefxItem: AppHeadIcon(
                            action: () {
                              orderController.update();
                            },
                          ),
                          isTowIcon: true,
                        ),
                        SizedBox(
                          height: 47.h,
                        ),
                        Center(
                          child: Container(
                            width: 327.w,
                            height: 92.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 29.h, right: 22.w),
                                  child: Image.asset(
                                    '${orderController.orderImageMasseage[order.stutes!]['icon']}',
                                    width: 59.w,
                                    color: Colors.black,
                                    height: 39.h,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 24.h, left: 25.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 220.w,
                                        child: Text(
                                          'حالة الطلب',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        width: 220.w,
                                        child: Text(
                                          '${orderController.orderImageMasseage[order.stutes!]['title']}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.sp),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 26.h,
                        ),
                        Container(
                          width: 327.w,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.sp),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 9,
                                    offset: Offset(0, 4))
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 11.w,
                                top: 16.h,
                                bottom: 12.h,
                                right: 11.w),
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _rowText(
                                      topPadeing: 10,
                                      Rchildren: Text(
                                        'رقم الهاتف ',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                      Lchildren: Text(
                                        '${order.phone}',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 1,
                                      )),
                                  _rowText(
                                      topPadeing: 13,
                                      Rchildren: Text(
                                        'الاسم',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                      Lchildren: Text(
                                        order.userName!,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 1,
                                      )),
                                  _rowText(
                                      topPadeing: 13,
                                      Rchildren: Text(
                                        'الموقع',
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color:
                                                Colors.black.withOpacity(0.5)),
                                      ),
                                      Lchildren: Text(
                                        userInfo.state ?? 'لا يوجد',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 2,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          width: 327.w,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 239, 230, 197),
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 11.w,
                                top: 16.h,
                                bottom: 12.h,
                                right: 11.w),
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  order.itemNumber == 0
                                      ? SizedBox.shrink()
                                      : orderController.orderDetiles.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: orderController
                                                  .orderDetiles.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return _rowText(
                                                    orderType: 's',
                                                    isProd: true,
                                                    count: order
                                                        .productsId![index]
                                                        .toString()
                                                        .split('@')[1],
                                                    topPadeing: 13,
                                                    Rchildren: Text(
                                                      '${orderController.orderDetiles[index].title}',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                    ),
                                                    Lchildren: Text(
                                                      '${NumberFormat('#,##0', 'en_US').format(double.parse(orderController.orderDetiles[index].price.toString()))}',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      maxLines: 1,
                                                    ));
                                              },
                                            )
                                          : Text('جار عرض المواد ...'),
                                  SizedBox(
                                    height: 20.h,
                                  ),

                                  // _rowText(
                                  //     topPadeing: 13,
                                  //     Rchildren: Text(
                                  //       'السعر الكلي ',
                                  //       style: TextStyle(
                                  //           fontSize: 14.sp,
                                  //           color: Colors.black
                                  //               .withOpacity(0.5)),
                                  //     ),
                                  //     Lchildren: Text(
                                  //       '${NumberFormat('#,##0', 'en_US').format(double.parse(order.totlPrice.toString()))}',
                                  //       style: TextStyle(
                                  //           fontSize: 12.sp,
                                  //           fontWeight: FontWeight.w800),
                                  //       maxLines: 1,
                                  //     )),
                                  // _rowText(
                                  //     topPadeing: 13,
                                  //     Rchildren: Text(
                                  //       'الخصم',
                                  //       style: TextStyle(
                                  //           fontSize: 14.sp,
                                  //           color: Colors.black
                                  //               .withOpacity(0.5)),
                                  //     ),
                                  //     Lchildren: Text(
                                  //       maxLines: 1,
                                  //       '0',
                                  //       style: TextStyle(
                                  //           fontSize: 12.sp,
                                  //           fontWeight: FontWeight.w800),
                                  //     )),
                                  Divider(
                                    color: Colors.grey.withOpacity(0.3),
                                  ),
                                  _rowText(
                                    topPadeing: 13,
                                    Rchildren: Text(
                                      'المبلغ الكلي',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                    Lchildren: Text(
                                      '${NumberFormat('#,##0', 'en_US').format(double.parse('${order.totlPrice.toString()}'))}',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w800),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  order.note != null
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 0.w),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(9.r),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 15.h),
                                              child: Text(
                                                  'ملاحظة : ${order.note.toString()}'),
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        // AppBoton(
                        //   titel: 'الرجوع الى المتجر',
                        //   onTap: () {
                        //     Get.back();

                        //     navBarController.chingPageIndex(0);
                        //   },
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text('حليب'),
                                  Checkbox(
                                    value: order.millk,
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                              Text('  |  '),
                              Row(
                                children: [
                                  Text('غاز'),
                                  Checkbox(
                                    value: order.gas,
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                              Text('  |  '),
                              Row(
                                children: [
                                  Text('شكر'),
                                  Checkbox(
                                    value: order.suger,
                                    onChanged: (value) {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
            }));
  }

  Widget _rowText({
    double topPadeing = 24,
    String? count,
    String? orderType,
    bool isProd = false,
    Widget Rchildren = const Text('data'),
    Widget? Lchildren = const Text('data'),
    Widget? childm = const Text('data'),
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadeing.h),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          count != null
              ? SizedBox(width: 33.w, child: Text('$count x '))
              : SizedBox.shrink(),
          SizedBox(
              width: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(child: Rchildren!),
                  isProd ? Text(orderType!) : SizedBox.shrink()
                ],
              )),
          SizedBox(width: 70.w, child: Lchildren!),
        ],
      ),
    );
  }
}
