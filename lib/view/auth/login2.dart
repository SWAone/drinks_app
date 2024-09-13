import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prostore/controller/auth/sgin_in.dart';
import 'package:prostore/widget/app_input.dart';
import 'package:hexcolor/hexcolor.dart';

class Login2 extends StatelessWidget {
  const Login2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SginInController>(
          init: SginInController(),
          builder: (sginCtrl) {
            return Container(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/order_icon/abc.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
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
                            child: Center(
                              child: Form(
                                key: sginCtrl.key2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                    ),
                                    AppTextInput(
                                      keyboardType: TextInputType.phone,
                                      onSaved: (p0) {
                                        sginCtrl.phone = p0;
                                      },
                                      lable: 'رقم الهاتف',
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    AppTextInput(
                                      pasword: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      onSaved: (p0) {
                                        sginCtrl.password = p0;
                                      },
                                      botomPading: 44,
                                      lable: 'كلمة السر',
                                    ),
                                    SizedBox(
                                      height: 80.h,
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          sginCtrl.login();
                                        },
                                        child: !sginCtrl.loding
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                  left: 30.w,
                                                  right: 30.w,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: HexColor('#354369'),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            26.5.sp)),
                                                child: Center(
                                                    child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    31.w,
                                                                vertical: 15.h),
                                                        child: Text(
                                                          'تسجيل الدخول',
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ))),
                                              )
                                            : Center(
                                                child: LottieBuilder.asset(
                                                  'assets/anmtions/home_anmtion/mainLoding.json',
                                                  width: 40.w,
                                                  height: 55.h,
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Padding(
                          padding: EdgeInsets.only(
                            top: 30.h,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 40);

    var firstControlPoint = Offset(size.width / 4, 0);
    var firstEndPoint = Offset(size.width / 2, 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), 80);
    var secondEndPoint = Offset(size.width, 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
