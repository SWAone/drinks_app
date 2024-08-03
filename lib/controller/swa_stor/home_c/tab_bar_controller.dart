import 'package:get/get.dart';

class TabBarController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
