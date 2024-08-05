import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prostore/controller/swa_stor/nav/nav_bar_controller.dart';
import 'package:prostore/model/user.dart';
import 'package:prostore/view/auth/root_auth.dart';
import 'package:prostore/local/local.dart';
import 'package:prostore/nav_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'local/local_controller.dart';

NavBarController navBarController = Get.put(NavBarController());
GetStorage box = GetStorage();
var auth;
int lanIndx = 0;
int thaem = 0;
User userInfo = User.fromJson({"name": 'null', "phone": "-1"});
bool isGeust = false;
void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  auth = await box.read('userId');
  isGeust = await box.read('isGeust') ?? false;
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('drink');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  LocaleController controller = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    Get.put(LocaleController());
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
            textDirection: TextDirection.rtl,
            translations: Mylocal(),
            locale: controller.initLang,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 0.9),
                  child: child!);
            },
            home: auth != null ? NavBar() : RootAuth(),
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                useMaterial3: true,
                fontFamily: 'LamaSans'));
      },
      designSize: const Size(375, 812),
    );
  }
}
