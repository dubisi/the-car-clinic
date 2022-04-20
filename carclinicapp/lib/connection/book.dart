import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  Future<bool> book({
    required String carReg,
    required String service,
    required String date,
    required String price,
  }) async {
    final response = await http.post(Uri.parse("http://localhost:7000/book"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "carReg": carReg,
          "description": service,
          "localDate": date,
          "price": price
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getBookings(String email) async {
    print('kkkkkkkk' + email);
    final response = await http.get(
      Uri.parse("http://localhost:7000/book?email=" + email),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }
}
