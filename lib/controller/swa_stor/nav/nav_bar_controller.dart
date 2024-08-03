import 'package:get/get.dart';

class NavBarController extends GetxController {
  int pageIndex = 0;

  void chingPageIndex(index) {
    pageIndex = index;
    update();
  }
}
