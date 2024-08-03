import 'package:flutter/material.dart';

class AdsModel {
  String? id;
  String? img;
  static int skip = 0;
  static bool skipLoding = false;
  AdsModel.formJson(Map map) {
    img = map['img'];
  }

  AdsModel.gnerateList(
    List items,
    List<AdsModel> allitems,
  ) {
    for (var ele in items) allitems.add(AdsModel.formJson(ele));
  }
}
