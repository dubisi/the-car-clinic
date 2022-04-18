import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Http {
  late int id = 1;

  Future<bool> register(name, surname, number, email, pwd) async {
    final response = await http.post(
      Uri.parse("http://localhost:7000/register"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "surname": surname,
        "number": number,
        "email": email,
        "password": pwd
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
