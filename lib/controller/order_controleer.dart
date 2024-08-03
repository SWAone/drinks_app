import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/ads_model.dart';
import 'package:prostore/model/category_model.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/model/order_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class OrderController extends GetxController {
  List<Order> orders = [];
  ScrollController scrollController = ScrollController();

  List<String> stats = [
    'قيد المراجعة',
    'قيد التوصيل',
    'تم الرفض',
    'اكتمل التوصيل'
  ];
  List<Color> statsColor = [
    Colors.red,
    Colors.green,
    Colors.green,
    Colors.green,
  ];
  bool lodingOrder = false;
  //هنا للتاكد هل اني مسوي جلب كل البيانات حتئ اذا جايبهن ميحتاج اجيبهن مره ثاني كبل اضيف عليهن الجديد
  bool isGetAllOrders = false;
  List<Map> orderImageMasseage = [
    {
      "title": 'قيد المراجعة',
      "icon":
          'assets/order_icon/waiting-while-reading-sit-wait-waiting-room-svgrepo-com.png',
      "body": "سيتم تاكيد طلبك قريبا"
    },
    {
      "title": 'تم تاكيد الطلب',
      "icon": 'assets/cart_icons/Frame.png',
      "body": "سيصل طلبك باقرب وقت"
    },
  ];
  int isSelcted = 0;
  bool isNoOrdersFiond = true;
  List<ItemModel> orderDetiles = [];
  @override
  void onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Order.skip += 3;
        // lodingOrder = true;
        // fecheAlldOrder(isFirstReq: false);
        getUserOrder(isFirstReq: false);
      }
    });
    super.onInit();
  }

  insertOrderToLocalAndFachData({required Map order}) async {
    List orderss = box.read('orrderss') ?? [];
    orderss.add(order['_id']);
    if (isGetAllOrders) {
      // var r = await Api.fetchData(
      //     path: '/order/${order['_id']}', lableReslut: 'result');
      // print('rrrrrrrrr');
      // print(r);
      // orders.add(Order.fromJson(r));
      // print(orderss.length);
      update();
    } else {
      fecheAlldOrder();
    }
    box.write('orrderss', orderss);
  }

  int i = 0;
  int counter = 0;
  List complietedOrderIndex = [];
  bool lodingFechOrder = false;
  Dio dio = Dio();
  int skip = 0;
  bool empty = false;
  bool lodingggg = false;
  Future<void> getUserOrder({
    bool isFirstReq = true,
  }) async {
    lodingggg = true;
    if (isGeust) {
      orders.clear();
      update();
      return;
    }
    if (isFirstReq) {
      skip = 0;
      orders.clear();
      lodingFechOrder = true;

      // fechingOrderLoding = true;
      update();
    } else {
      skip += 6;

      lodingOrder = true;
      update();
    }

    var x = '${Api.apiUrl}/order/order/userId/${userInfo.id}?skip=$skip';
    print(x);
    try {
      var response = await dio.get(x);

      if (response.statusCode == 200) {
        for (var element in response.data['result']) {
          orders.add(Order.fromJson(element));
        }
      } else {
        print('Failed to fetch orders. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching orders: $e');

      Get.defaultDialog(title: 'حدث خطا بالسيرفر', content: Text('خطااا'));
    }
    lodingFechOrder = false;

    lodingOrder = false;
    lodingggg = false;
    update();
  }

  void fecheAlldOrder({bool isFirstReq = true}) async {
    List ordersId = box.read('orrderss') ?? [];
    if (isFirstReq) {
      lodingFechOrder = true;
      isGetAllOrders = true;
      update();
    }

    var respons;
    for (i = counter; i <= Order.skip; i++) {
      if (i < ordersId.length) {
        try {
          respons = await Api.fetchData(
              path: '/order/${ordersId[i]}', lableReslut: 'result');

          if (respons != null) {
            if (respons['stutes'] == 3 || respons['stutes'] == 2) {
              complietedOrderIndex.add(i);
            }
            orders.add(Order.fromJson(respons));

            isNoOrdersFiond = respons.isEmpty;
            counter = i + 1;
          }
        } catch (e) {
          Order.skip -= 3;
          lodingOrder = false;
          lodingFechOrder = false;

          update();
        }
      } else {}
    }
    Order.skip += 3;
    lodingFechOrder = false;

    lodingOrder = false;
    update();
    try {
      for (var element in complietedOrderIndex) {
        if (ordersId.length > element) {
          ordersId.removeAt(element);
          complietedOrderIndex.remove(element);
        }
      }

      await box.write('orrderss', ordersId);
    } catch (e) {
      print(e);
    }
    lodingOrder = false;
    update();
  }

  void fecheOneOrder({required List ordersId}) async {
    orderDetiles.clear();
    for (var element in ordersId) {
      element = element.toString().split('@')[0];

      try {
        Map respons = await Api.fetchData(path: '/product/$element');
        orderDetiles.add(ItemModel.formJson(respons));
      } catch (e) {
        Get.back();
        Get.snackbar('حدث خطأ', 'حدث خطا ما ربما يكون الطلب غير موجود',
            backgroundColor: Colors.red.withOpacity(0.5));
      }
    }

    update();
  }

  Future fetchProductDetails(List productIds) async {
    orderDetiles.clear();

    update();
    final url = Uri.parse('${Api.apiUrl}/product/details');
    final headers = {'Content-Type': 'application/json'};

    print('${Api.apiUrl}/product/details');

    final body = jsonEncode({'productIds': productIds});

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var element in data['products']) {
          orderDetiles.add(ItemModel.formJson(element));
        }
      } else {
        print('Failed to fetch product details. Status code: ${response.body}');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
    update();
  }
}
