import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/api/api.dart';
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
                          title: 'معاينة الطلب',
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

                        Padding(
                          padding: EdgeInsets.only(
                              left: 11.w, top: 16.h, bottom: 12.h, right: 11.w),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                orderController.orderDetiles.isNotEmpty
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            orderController.orderDetiles.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                EdgeInsets.only(bottom: 22.h),
                                            padding: EdgeInsets.only(
                                                top: 15.h, bottom: 15.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 10)
                                                ]),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  '${Api.imgsPath}${orderController.orderDetiles[index].imags!}',
                                                  width: 87.w,
                                                  height: 130.h,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${orderController.orderDetiles[index].title}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    SizedBox(
                                                      height: 9.h,
                                                    ),
                                                    Text(
                                                      '${orderController.orderDetiles[index].price} د.ع',
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    SizedBox(
                                                      height: 9.h,
                                                    ),
                                                    Text(
                                                      '${homeController.idToCategory(id: orderController.orderDetiles[index].category!)}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                    SizedBox(
                                                      height: 9.h,
                                                    ),
                                                    SizedBox(
                                                      width: 250.w,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Divider(
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          SizedBox(
                                                            width: 4.w,
                                                          ),
                                                          Text(order.date
                                                              .toString()
                                                              .split('T')[0])
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Text('جار عرض المواد ...'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 0.h),
                              child: Text(
                                  'السعر الكلي : ${NumberFormat('#,##0', 'en_US').format(double.parse('${order.totlPrice.toString()}'))}'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        order.note != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 0.h),
                                    child: Text(
                                        'ملاحظة : ${order.note.toString()}'),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 20.h,
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
                ],
              )),
          SizedBox(width: 70.w, child: Lchildren!),
        ],
      ),
    );
  }
}
