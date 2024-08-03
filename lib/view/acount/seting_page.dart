import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/controller/swa_stor/cash_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/controller/swa_stor/home_c/setting_controller.dart';
import 'package:prostore/main.dart';

import 'package:prostore/widget/app_boton.dart';
import 'package:prostore/widget/app_head_icon.dart';
import 'package:prostore/widget/app_input.dart';
import 'package:prostore/widget/home_widget/app_head.dart';

class SetingPage extends StatelessWidget {
  CashController cashController = Get.put(CashController());

  HomeController homeController = Get.put(HomeController());
  SetingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GetBuilder<SetingController>(
            init: SetingController(),
            builder: (controller) {
              return Column(
                children: [
                  AppHead(
                      prefxItem: AppHeadIcon(),
                      isTowIcon: true,
                      title: 'اعدادات الحساب'),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 33.w, right: 33.w, top: 42.h, bottom: 58.h),
                    child: Center(
                      child: Image.asset(
                        'assets/acount_icons/user-pen-svgrepo-com.png',
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 31.w, right: 31.w, bottom: 121.h),
                    child: Column(
                      children: [
                        AppTextInput(
                            lable: 'الاسم', controlle: controller.name),
                        AppTextInput(
                            lable: 'الموقع', controlle: controller.loction),
                        AppTextInput(
                            lable: 'رقم الهاتف', controlle: controller.phone),
                      ],
                    ),
                  ),
                  !controller.isLodingEdit
                      ? AppBoton(
                          titel: 'حفض التغيرات',
                          onTap: () async {
                            print(controller.loction);
                            userInfo.name = controller.name.text;
                            userInfo.phone = controller.phone.text;

                            cashController.update();

                            await controller
                                .updateUser(userInfo!.id.toString());
                            homeController.update();
                          })
                      : LottieBuilder.asset(
                          'assets/anmtions/home_anmtion/mainLoding.json',
                          width: 30.w,
                          height: 50.h,
                        )
                ],
              );
            }),
      ),
    ));
  }
}
