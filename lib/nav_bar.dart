import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/controller/swa_stor/nav/nav_bar_controller.dart';
import 'package:prostore/view/home_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prostore/view/cart/cart_sc.dart';
import 'package:prostore/view/order/my_orders.dart';
import 'package:prostore/view/search/search.dart';

import 'view/acount/acount_sc.dart';

class NavBar extends StatelessWidget {
  OrderController orderController = Get.put(OrderController());
  NavBar({super.key});
  List sc = [
    HomePageSc(),
    CartSc(),
    MyOrders(),
    AcountSc(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      init: NavBarController(),
      builder: (controller) {
        return Scaffold(
          body: sc[controller.pageIndex],
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: HexColor('#354369'),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    item(
                      iconurl: 'assets/navbar_icon/home.png',
                      isSelected: controller.pageIndex == 0,
                      onTap: () {
                        controller.chingPageIndex(0);
                      },
                    ),
                    item(
                        iconurl: 'assets/navbar_icon/Combined Shape.png',
                        isSelected: controller.pageIndex == 1,
                        onTap: () {
                          controller.chingPageIndex(1);
                        },
                        lable: 'السلة'),
                    item(
                      iconurl: 'assets/order_icon/Desk.png',
                      lable: 'الطلبات',
                      isSelected: controller.pageIndex == 2,
                      onTap: () {
                        if (orderController.lodingggg) {
                        } else {
                          orderController.skip = 0;
                          orderController.getUserOrder(isFirstReq: true);
                        }

                        // try {
                        //   if (orderController.orders.isEmpty)
                        //     orderController.fecheAlldOrder();
                        // } catch (e) {
                        //   print("eroeerrrrrrrrr $e");
                        // }
                        controller.chingPageIndex(2);
                      },
                    ),
                    item(
                      iconurl: 'assets/navbar_icon/user.png',
                      lable: 'الحساب',
                      isSelected: controller.pageIndex == 3,
                      onTap: () {
                        controller.chingPageIndex(3);
                      },
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget item(
      {String iconurl = '',
      String lable = 'الرئيسية',
      bool isSelected = false,
      void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: HexColor('#354369'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSelected
                ? Container(
                    height: 8.h,
                    width: 37.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r))),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 7.h),
              child: Image.asset(
                iconurl,
                width: 21.w,
                height: 22.h,
                color: isSelected ? Colors.white : Colors.grey,
                opacity: AlwaysStoppedAnimation(2),
              ),
            ),
            Text(
              lable,
              style: TextStyle(color: isSelected ? Colors.white : Colors.grey),
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }
}
