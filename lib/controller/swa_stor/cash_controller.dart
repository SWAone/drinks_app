import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/controller/order_controleer.dart';
import 'package:prostore/controller/swa_stor/home_c/home_controller.dart';
import 'package:prostore/controller/swa_stor/nav/nav_bar_controller.dart';
import 'package:prostore/fcm.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/model/order_model.dart';
import 'package:prostore/view/cart/cart_sc.dart';
import 'package:prostore/view/order/check_out.dart';

class CashController extends GetxController {
  List ele = [];
  double totlprice = 0;
  List<ItemModel> paskketProducts = [];
  NavBarController navBarController = Get.put(NavBarController());
  HomeController homeController = Get.put(HomeController());
  bool addToCartLoding = false;
  OrderController orderController = Get.put(OrderController());
  @override
  void onInit() {
    fechPascetData();
    super.onInit();
  }

  void insertTocash(
    String id,
    String table,
    String path,
    List fechedEle,
    List resultElemnt,
    GetxController controller,
    ItemModel item,
  ) async {
    print('isert int $table');
    fechedEle = box.read(table) ?? [];
    if (fechedEle.isNotEmpty) {
      if (isLiked(id, fechedEle)) {
        Get.back();

        navBarController.chingPageIndex(1);
        update();
        return;
      } else {
        addToCartLoding = true;
        update();
        fechedEle = box.read(table);
        fechedEle.add(id);

        box.write(table, fechedEle);
        fechedEle = box.read(table);
        var result = await Api.fetchData(path: '/$path/$id');
        resultElemnt.add(ItemModel.formJson(result));
        calculetTotlePrice();
        controller.update;
        update();
      }

      update();

      return;
    }
    box.write(table, [id]);

    fechedEle = box.read(table);

    var result = await Api.fetchData(path: '/$path/$id');
    resultElemnt.add(ItemModel.formJson(result));
    calculetTotlePrice();

    controller.update;
    update();
  }

  bool isLiked(String id, List liked) {
    if (liked.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  void calculetTotlePrice() {
    totlprice = 0;
    addToCartLoding = false;

    for (var element in paskketProducts) {
      totlprice += element.price!;
    }
    update();
  }

  void fechPascetData() async {
    try {
      print('=f ${box.read('f6')}');
      if (await box.read('f6') != null) {
        for (var element in box.read('f6')) {
          Map respons = await Api.fetchData(path: '/product/$element');
          paskketProducts.add(ItemModel.formJson(respons));
        }
        calculetTotlePrice();
        update();
      }
    } catch (e) {}
  }

  bool suger = false;
  bool millk = false;
  bool gas = false;

  TextEditingController adminSendOrderControler = TextEditingController();

  bool newOrderLOding = false;
  void newOrder() async {
    print(adminSendOrderControler.text);
    List allPascetItemInCash = await box.read('f6');

    for (var i = 0; i < paskketProducts.length; i++) {
      var m = allPascetItemInCash[i];
      m += '@${paskketProducts[i].count}';

      allPascetItemInCash[i] = m;
    }
    print(box.read('f6'));
    newOrderLOding = true;
    update();
    List locton = box.read('loction') ?? ['1', '2'];
    print(locton);
    await Api.postData(
      body: {
        "userName": userInfo.name,
        "userid": userInfo.id,
        "productsId": allPascetItemInCash,
        "totlPrice": totlprice,
        "phone": userInfo.phone,
        "itemNumber": paskketProducts.length,
        "stutes": 0,
        "date": DateTime.now().toIso8601String(),
        "pass": "swaaws",
        "admin": adminSendOrderControler.text,
        "milk": millk,
        "suger": suger,
        "gas": gas
      },
      path: '/order',
      erorr: (erorr) {
        Get.back();

        print(erorr);
      },
      sucsues: (respons) async {
        print(respons['result']);
        try {
          await Api.postData(
            path: '/send',
            body: {
              "title": 'طلب جديد',
              "body": 'مرسل الطلب ${userInfo.name}',
              "topic": 'order'
            },
            sucsues: (respons) {
              print(respons);
            },
          );
        } catch (e) {
          print('eror notfction $e');
        }

        orderController.orders.add(Order.fromJson(respons['result']));
        orderController.update();
        orderController.counter += 1;
        orderController.insertOrderToLocalAndFachData(
          order: respons['result'],
        );
        newOrderLOding = false;
        update();
        // Get.back();
        box.remove('f6');
        paskketProducts.clear();
        navBarController.chingPageIndex(2);
        orderController.skip = 0;
        orderController.getUserOrder(isFirstReq: true);
        // Get.to(() => CheckOutOrder());
      },
    );
    totlprice = 0;

    update();
  }

  bool getNewPostionLoding = false;
}
