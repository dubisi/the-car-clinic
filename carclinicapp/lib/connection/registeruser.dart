import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Http {
  late int id = 1;

  Future<bool> register(
      {required String name,
      required String surname,
      required String number,
      required String email,
      required String location,
      required String pwd}) async {
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
        "location": location,
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
