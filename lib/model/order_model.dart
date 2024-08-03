class Order {
  String? userid, phone, date, id, userName, note;
  List? productsId;
  bool? suger, gas, millk;
  int? itemNumber, stutes;
  dynamic totlPrice;

  static int skip = 2;
  Order.fromJson(Map map) {
    try {
      gas = map['gas'];
      millk = map['milk'];
      suger = map['suger'];

      note = map['admin'];
      userid = map['userid'];
      id = map['_id'];
      productsId = map['productsId'];
      phone = map['phone'];
      totlPrice = map['totlPrice'];
      date = map['date'];
      stutes = map['stutes'];
      userName = map['userName'];
    } catch (e) {
      print('from order model === $e');
    }
  }
}
