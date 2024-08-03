import 'dart:math';

import 'package:flutter/material.dart';

class ItemModel {
  String? id;
  String? title;
  String? body;
  int? price;
  int? dicount;
  String? dicountDate;
  int? type;
  int? v, sellit;
  String? imags;
  String? category;
  int count = 1;
  bool isChckBox = true;
  static int skip = 0;
  static int skip2 = 0;
  static bool skipLoding = false;
  static bool skipLoding2 = false;
  ItemModel() {}
  ItemModel.formJson(Map map) {
    id = map['_id'];
    title = map['title'];
    body = map['body'];
    price = map['price'];
    v = map['v'];
    imags = map['img'];
    category = map['category'];
  }

  ItemModel.gnerateList(List items, List<ItemModel> allitems) {
    for (var ele in items) {
      allitems.add(ItemModel.formJson(ele));
    }
  }
}
