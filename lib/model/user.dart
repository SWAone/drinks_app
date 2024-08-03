class User {
  String? name, id, password, birthday, state;
  var phone;
  int? number_of_order;

  int? stats;
  User.fromJson(Map map) {
    number_of_order = map['number_of_order'];
    birthday = map['birthday'];
    state = map['state'] ?? '';
    name = map['name'];
    id = map['_id'];
    phone = map['phone'];
    password = map['password'];
  }
}
