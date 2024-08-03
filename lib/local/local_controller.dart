import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends GetxController {
  int lanIndex = 0;
  var sherdBox = GetStorage();
  Locale? initLang;
  @override
  void onInit() {
    initLang = sherdBox.read('lan') == "kr" ? Locale('kr') : Locale('ar');
    sherdBox.read('lan') == "kr" ? lanIndex = 1 : lanIndex = 0;
    super.onInit();
  }

  void changeLang(String codelan) {
    if (codelan == 'ar') {
      lanIndex = 0;
    } else {
      lanIndex = 1;
    }
    Locale locale = Locale(codelan);
    sherdBox.write('lan', codelan);
    Get.updateLocale(locale);
  }
}
