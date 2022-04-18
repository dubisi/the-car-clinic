import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  Future<List> getDates() async {
    final response = await http.get(
      Uri.parse("http://localhost:7000/date"),
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
