import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prostore/api/api.dart';
import 'package:prostore/main.dart';
import 'package:prostore/model/ads_model.dart';
import 'package:prostore/model/category_model.dart';
import 'package:prostore/model/item_model.dart';
import 'package:prostore/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeController extends GetxController {
  List<ItemModel> products = [];

  List<ItemModel> filterProdeucts = [];
  String serchText = '';
  List<ItemModel> sortedProdect = [];
  List<CategoryMdel> categores = [];
  List<ItemModel> itemByCategory = [];
  List<ItemModel> serachElemnt = [];
  List<ItemModel> filtersEle = [];
  GlobalKey<FormState> key = GlobalKey<FormState>();

  List<AdsModel> adss = [];
  List<ItemModel> pasketprodects = [];
  final ScrollController productsScrollController = ScrollController();
  final ScrollController filterScrollController = ScrollController();
  final ScrollController allcategoryController = ScrollController();

  final ScrollController filterPriceScrollController = ScrollController();
  final ScrollController serchScrollController = ScrollController();

  final ScrollController categoryScrollController = ScrollController();
  final ScrollController adsScrollController = ScrollController();

  final box = GetStorage();
  int productsSki = 1;

  bool skipProductLoding = false,
      skipMoatProductsLoding = false,
      skipAdsLoding = false;
  int selctedCategoryFilter = 0;
  RangeValues currentRangeValues = const RangeValues(40, 80);
  @override
  String idToCategory({
    required String id,
  }) {
    try {
      CategoryMdel? category = categores.firstWhere(
        (element) => element.id == id,
      );

      return category.title!;
    } catch (e) {
      return "غير مصنف";
    }
  }

  String discountDayCalculate(productDiscountDtae) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    DateTime startDate = format.parse(dataeNow!);
    DateTime endDate = format.parse(productDiscountDtae);

    Duration difference = endDate.difference(startDate);

    return difference.inDays.toString();
  }

  String? dataeNow;
  bool isCatgoryDisplyOnAllPrductPage = false;
  String catogoryId = '';
  int skipMostProduct = 0;
  bool isMostProductTap = false;
  bool isSerch = false;
  void onInit() async {
    // filterScrollController.addListener(() async {
    //   print(filterScrollController.position.pixels);
    //   if (filterScrollController.position.pixels ==
    //       filterScrollController.position.maxScrollExtent) {
    //     print('ss${filterScrollController}');
    //   }
    // });

    serchScrollController.addListener(() {
      if (filterScrollController.position.pixels ==
          filterScrollController.position.maxScrollExtent) {
        print('ssssssrchsss${filterScrollController}');
      }
    });
    try {
      getUserInfo(userId: box.read('userId') ?? 'null');
      AdsModel.gnerateList(await Api.fetchData(path: '/ads?skip=0'), adss);
      update();
      ItemModel.gnerateList(
          await Api.fetchData(path: '/product?skip=0'), products);

      update();
      CategoryMdel.gnerateList(
          await Api.fetchData(path: '/category?skip=0'), categores);
      update();
      // ItemModel.gnerateList(
      //     await Api.fetchData(path: '/product/sort?skip=0'), sortedProdect);
      // update();

      onScrollToEnd(
        productsScrollController,
        () async {
          print('/product?skip=${ItemModel.skip}');

          ItemModel.skip += 6;
          ItemModel.skipLoding = true;
          update();
          ItemModel.gnerateList(
              await Api.fetchData(path: '/product?skip=${ItemModel.skip}'),
              products);

          ItemModel.skipLoding = false;
          update();
          print('/product?skip=${ItemModel.skip}');
        },
      );
      onScrollToEnd(
        filterScrollController,
        () async {
          update();
          if (isCatgoryDisplyOnAllPrductPage) {
            CategoryMdel.skipLoding = true;
            ItemModel.skipLoding = true;

            update();
            getElemntByCategory(categoryId: catogoryId, isFirstTime: false);
            print('is gatoooo');
          } else {
            ItemModel.skipLoding = true;

            print('is Not gatoooo');
            if (isMostProductTap) {
              print('okkkkkkkkkkkkkkkkkk isMostProductTap');
              skipMostProduct += 6;
              print('/product/sort?skip=$skipMostProduct');
              ItemModel.gnerateList(
                  await Api.fetchData(
                      path: '/product/sort?skip=$skipMostProduct'),
                  sortedProdect);
            } else {
              print('nooooooooooooo isMostProductTap');

              ItemModel.skip += 6;

              ItemModel.gnerateList(
                  await Api.fetchData(path: '/product?skip=${ItemModel.skip}'),
                  products);
              print('/product?skip=${ItemModel.skip}');
            }

            ItemModel.skipLoding = false;
          }
          CategoryMdel.skipLoding = false;

          update();
        },
      );

      filterPriceScrollController.addListener(() async {
        if (filterPriceScrollController.position.pixels ==
            filterPriceScrollController.position.maxScrollExtent) {
          if (isSerch) {
            serachEle(text: serchText, lableResult: 'items', isFirstTim: false);
          }
          filterEle(
            max: currentRangeValues.end.toString(),
            min: currentRangeValues.start.toString(),
            isFirsTime: false,
            category: categores[selctedCategoryFilter].id.toString(),
            lableResult: 'items',
          );
          print('new filter data >>>.');
        }
      });

      // onScrollToEnd(
      //   categoryScrollController,
      //   () async {
      //     CategoryMdel.skip += 5;
      //     CategoryMdel.skipLoding = true;
      //     update();

      //     CategoryMdel.gnerateList(
      //         await Api.fetchData(path: '/category?skip=${CategoryMdel.skip}'),
      //         categores);
      //     CategoryMdel.skipLoding = false;
      //     update();
      //   },
      // );
      onScrollToEnd(
        allcategoryController,
        () async {
          CategoryMdel.skip += 10;
          CategoryMdel.skipLoding = true;

          update();

          print('/category?skip=${CategoryMdel.skip}');
          CategoryMdel.gnerateList(
              await Api.fetchData(path: '/category?skip=${CategoryMdel.skip}'),
              categores);
          CategoryMdel.skipLoding = false;
          update();
        },
      );

      // onScrollToEnd(
      //   filterScrollController,
      //   () async {
      //     skipFilter += 5;
      //     skipffilter = true;
      //     print('filter');
      //     update();
      //     ItemModel.gnerateList(
      //         await Api.fetchData(path: '/product?skip=$skipFilter'),
      //         filterProdeucts);
      //     skipffilter = false;
      //     update();
      //   },
      // );
      onScrollToEnd(
        adsScrollController,
        () async {
          AdsModel.skip += 10;
          AdsModel.skipLoding = true;
          update();
          print('/ads?skip=${AdsModel.skip}');
          AdsModel.gnerateList(
              await Api.fetchData(path: '/ads?skip=${AdsModel.skip}'), adss);
          AdsModel.skipLoding = false;
          update();
        },
      );
    } catch (e) {
      print(e);
    }

    try {
      var res = await http
          .get(Uri.parse('https://worldtimeapi.org/api/timezone/Asia/Baghdad'));
      dataeNow = jsonDecode(res.body)['datetime'].toString().split('T')[0];
      update();
    } catch (e) {}

    super.onInit();
  }

  void onScrollToEnd(ScrollController controller, dynamic action()) {
    controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        print('object');
        action();
      }
    });
  }

  getFilterData({required String price, required String ctegory}) async {
    filterProdeucts.clear();
    ItemModel.gnerateList(
        await Api.fetchData(path: '/product?skip=0'), filterProdeucts);
    update();
  }

  int skip = 0;
  bool loding = true;

  Future<void> getElemntByCategory(
      {required String categoryId, required bool isFirstTime}) async {
    if (isFirstTime) {
      skip = 0;
      loding = true;
      update();
      itemByCategory.clear();
    } else {
      skip += 6;
    }
    print('/product/categorye/$categoryId?skip=$skip');
    try {
      ItemModel.gnerateList(
          await Api.fetchData(
              path: '/product/categorye/$categoryId?skip=$skip'),
          itemByCategory);
    } catch (e) {
      print('erorr $e');
    }

    loding = false;
    ItemModel.skipLoding = false;
    update();
  }

  bool isFoundElemntSerach = true;
  int skipSerch = 0;
  Future<void> serachEle(
      {required String text,
      required String lableResult,
      bool isFirstTim = true}) async {
    if (isFirstTim) {
      filterLoding = true;
      isFoundElemntSerach = true;
      serachElemnt.clear();
      update();
    }

    print(text);
    try {
      print('/product/search/ele/$text?skip=$skipSerch');
      ItemModel.gnerateList(
          await Api.fetchData(
              lableReslut: lableResult,
              path: '/product/search/ele/$text?skip=$skipSerch'),
          serachElemnt);
      isFoundElemntSerach = serachElemnt.isEmpty;
      filterLoding = false;
      skipSerch += 6;
      update();
    } catch (e) {
      filterLoding = false;

      update();
    }
  }

  int skipFilter2 = 0;
  bool filterLoding = false;
  Future<void> filterEle(
      {required String max,
      required String min,
      required bool isFirsTime,
      required String category,
      required String lableResult}) async {
    if (isFirsTime) {
      skipFilter2 = 0;
      filterLoding = true;
      update();
      filtersEle.clear();
      update();
    } else {
      loding = true;
      skipFilter2 += 6;
      update();
    }

    print(
        '/product/filter/ele?skip=$skipFilter2&min=$min&max=$max&category=$category');
    ItemModel.gnerateList(
        await Api.fetchData(
            lableReslut: lableResult,
            path:
                '/product/filter/ele?skip=$skipFilter2&min=$min&max=$max&category=$category'),
        filtersEle);
    filterLoding = false;
    loding = false;

    update();
  }

  getUserInfo({required String userId}) async {
    print('get user infff');
    try {
      if (box.read('isGeust') ?? false) {
        print('is gesssst user ing');

        isGeust = true;
        update();
        return;
      }

      final response = await http.get(Uri.parse('${Api.apiUrl}/auth/$userId'));
      if (response.statusCode == 200) {
        userInfo = User.fromJson(jsonDecode(response.body)['result']);
        update();
        print(jsonDecode(response.body)['result']);
        FirebaseMessaging messaging = FirebaseMessaging.instance;

        messaging.subscribeToTopic('drink');
        return userInfo;
      } else {
        box.remove('userId');
        // Get.offAll(SignUpPage());
      }
    } catch (e) {
      print('eroooer  $e');
    }
  }

  final currentDate = DateTime.now();
}
