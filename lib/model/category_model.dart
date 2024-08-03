import 'dart:math';

import 'package:flutter/material.dart';

class CategoryMdel {
  String? id;
  String? title;
  String? body;

  var img;
  static int skip = 0;
  static bool skipLoding = false;

  CategoryMdel.formJson(Map map) {
    id = map['_id'];
    title = map['title'];
    img = map['img'];
  }

  CategoryMdel.gnerateList(List items, List<CategoryMdel> allitems) {
    for (var ele in items) {
      allitems.add(CategoryMdel.formJson(ele));
    }
  }
}
