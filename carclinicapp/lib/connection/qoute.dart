import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  Future<bool> createQoute(
      {required String carReg, required String description}) async {
    final response = await http.post(Uri.parse("http://localhost:7000/quote"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "carReg": carReg,
          "description": description,
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getQuotes(String email) async {
    print('kkkkkkkk' + email);
    final response = await http.get(
      Uri.parse("http://localhost:7000/quote?email=" + email),
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
