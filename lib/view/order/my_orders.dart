import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/view/order/order_detelis.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prostore/widget/order_widget/order_box.dart';
import 'package:intl/intl.dart';

class MyOrders extends StatelessWidget {
  OrderController orderController = Get.put(OrderController());

  MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color(0xFFC0D3E4),
        systemNavigationBarDividerColor: AppColor.primaryColor));
    return SafeArea(
        child: WillPopScope(
      onWillPop: () {
        return exit(0);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: GetBuilder<OrderController>(
              init: OrderController(),
              builder: (orderController) {
                return Column(
                  children: [
                    AppHead(
                        prefxItem: GestureDetector(
                      onTap: () {
                        print('dd');
                        if (orderController.lodingggg) {
                        } else {
                          orderController.skip = 0;
                          orderController.getUserOrder();
                        }
                      },
                      child: Icon(
                        Icons.refresh_rounded,
                        size: 25.sp,
                      ),
                    )),
                    Expanded(
                      child: orderController.lodingFechOrder
                          ? Center(
                              child: LottieBuilder.asset(
                                  'assets/anmtions/home_anmtion/mainLoding.json'),
                            )
                          : orderController.orders.isNotEmpty
                              ? SizedBox(
                                  width: 336.w,
                                  child: ListView.builder(
                                    controller:
                                        orderController.scrollController,
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        top: 32.h, left: 4.w, right: 4.w),
                                    itemCount: orderController.orders.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          OrderBox(
                                            onTap: () {
                                              orderController
                                                  .fetchProductDetails(
                                                      orderController
                                                          .orders[index]
                                                          .productsId!);
                                              // orderController.fecheOneOrder(
                                              //     ordersId: orderController
                                              //         .orders[index]
                                              //         .productsId!);
                                              Get.to(() => OrderDetelis(
                                                    order: orderController
                                                        .orders[index],
                                                  ));
                                            },
                                            order:
                                                orderController.orders[index],
                                          ),
                                        ],
                                      );
                                    },
                                  ))
                              : Center(
                                  child: Text('لم تقم بعملية شراء الى الان')),
                    ),
                    orderController.lodingOrder
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: LottieBuilder.asset(
                              'assets/anmtions/home_anmtion/mainLoding.json',
                              width: 30.w,
                              height: 30.h,
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                );
              })),
    ));
  }
}
