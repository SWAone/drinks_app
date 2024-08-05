import 'dart:convert';
import 'package:http/http.dart' as http;

class FCMService {
  final String serverKey =
      'AAAAQ7kc2wQ:APA91bGq42faEhIciMCNi-EW9vGnkzks_GSl8JmvT26iY97iVGySDGBzQuH4jPqgLCW2NQB1eYfos2k-vkZ7MxRxfoBHkFqQHLn5l1ZPnizkRL1bYHiIdaj3mvfDFLrRHUe78CV66Xah'; // مفتاح الخادم الخاص بك

  Future<void> sendNotifications(
      {required String title, required String body, String topc = ''}) async {
    var respons = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': title, 'title': body},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'title': title,
            'body': body,
            'status': 'done',
            'to': "/topic/$topc"
          },
          'to': "/topics/$topc"
        },
      ),
    );
    print(respons.body);
  }
}
