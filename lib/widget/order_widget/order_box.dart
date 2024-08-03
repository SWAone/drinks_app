import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prostore/const/app_color.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/model/order_model.dart';
import 'package:prostore/view/order/order_detelis.dart';
import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/home_widget/app_head.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class OrderBox extends StatelessWidget {
  OrderController orderController = Get.put(OrderController());
  Order order;
  void Function()? onTap;
  OrderBox({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 336.w,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 18.h, left: 25.w, right: 12.w, bottom: 15.h),
            child: Column(
              children: [
                _rowText(
                    topPadeing: 0,
                    Rchildren: SizedBox(
                      width: 90.w,
                      child: Text(
                        order.date.toString().split('T')[0],
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.5)),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                    Lchildren: SizedBox()),
                _rowText(
                    mainAxisAlignment: MainAxisAlignment.start,
                    Rchildren: Text(
                      'رقم الهاتف ',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    Lchildren: Text(
                      ' :  ${order.phone}',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w800),
                    )),
                _rowText(
                    topPadeing: 19.h,
                    Lchildren: SizedBox.shrink(),
                    Rchildren: Row(
                      children: [
                        Text(
                          'اجمالي السعر : ',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        Text(
                          '${NumberFormat('#,##0', 'en_US').format(double.parse(order.totlPrice.toString()))} د.ع',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w800),
                        ),
                      ],
                    )),
                _rowText(
                  topPadeing: 19.h,
                  Rchildren: Container(
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(17.5.sp),
                        border: Border.all(color: Colors.black)),
                    width: 100.w,
                    height: 35.h,
                    child: Center(
                      child: Text(
                        'عرض المحتويات',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  Lchildren: Container(
                    width: 170.w,
                    child: Text(
                      order.stutes == 0 ? 'قيد المراجعة' : 'تم تاكيدالطلب',
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: orderController.statsColor[order.stutes!],
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
}
