import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  Future<List> getCars(String email) async {
    print(email);
    final response = await http.get(
      Uri.parse("http://localhost:7000/car?email=" + email),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 302) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  Future<bool> addCars(
      {required String brand,
      required String model,
      required String vinNumber,
      required String year,
      required String carRegistration,
      required String email}) async {
    final response = await http.post(Uri.parse("http://localhost:7000/car"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "brand": brand,
          "model": model,
          "vinNumber": vinNumber,
          "year": year,
          "carReg": carRegistration,
          "email": email
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
