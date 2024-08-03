import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/main.dart';
import 'package:prostore/nav_bar.dart';
import 'package:prostore/view/order/my_orders.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:hexcolor/hexcolor.dart';

class CheckOutOrder extends StatelessWidget {
  OrderController orderController = Get.put(OrderController());
  CheckOutOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          AppHead(
            title: 'حالة الطلب',
            prefxItem: AppHeadIcon(),
            isTowIcon: true,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 52.w, right: 52.w, top: 28.h, bottom: 43.h),
              child: Image.asset('assets/order_icon/Check out 4.png'),
            ),
          ),
          Text(
            'تم ارسال طلبك بنجاح',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 79.h,
          ),
          Center(
            child: Image.asset(
              'assets/order_icon/order (1) 2.png',
              width: 110.w,
              height: 110.h,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: 52.w, right: 52.w, top: 55.h, bottom: 108.h),
              child: Text(
                'شكرا لك على اختيارك DAVINCIS الرافدين  سعداء جدا بالتعامل معك يمكنك تفقد حالة طلبك من خلال الانتقال الى صفحة الطلبات',
                textAlign: TextAlign.center,
                style: TextStyle(color: HexColor('#33302E'), fontSize: 14.sp),
              ),
            ),
          ),
          AppBoton(
            titel: 'تتبع حالة الطلب',
            onTap: () {
              Get.back();
              // if (orderController.orders.isEmpty)
              //   orderController.fecheAlldOrder();

              navBarController.chingPageIndex(2);
              orderController.skip = 0;
              orderController.getUserOrder(isFirstReq: true);
            },
          ),
        ],
      ),
    ));
  }
}
