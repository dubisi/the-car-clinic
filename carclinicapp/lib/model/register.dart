import 'package:carclinicapp/connection/registeruser.dart';
import 'package:flutter/cupertino.dart';

class Register extends ChangeNotifier {
  String name = "";
  String surname = "";
  String email = "";
  String number = "";
  String pwd = "";

  Future<bool> register(
      {required String name,
      required String surname,
      required String number,
      required String email,
      required String location,
      required String pwd}) async {
    Http http = Http();

    return http.register(
        name: name,
        surname: surname,
        number: number,
        email: email,
        location: location,
        pwd: pwd);
  }
}
