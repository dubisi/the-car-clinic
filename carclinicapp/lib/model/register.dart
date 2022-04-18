
import 'package:carclinicapp/connection/registeruser.dart';
import 'package:flutter/cupertino.dart';

class Register extends ChangeNotifier {
  String name = "";
  String surname = "";
  String email = "";
  String number = "";
  String pwd = "";

  Future<bool> register(name,surname,number,email,pwd) async {
    Http http = Http();

    
    return http.register(name,surname,number,email,pwd);
  }
}
