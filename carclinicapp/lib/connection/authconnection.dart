import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  late int id = 1;

  Future<bool> login(String user, String pwd) async {
    final response = await http.post(
      Uri.parse("http://localhost:7000/login"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"user": user, "password": pwd}),
    );

    if (response.statusCode == 202) {
      return true;
    } else {
      return false;
    }
  }
}
