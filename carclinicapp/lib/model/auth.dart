import 'package:carclinicapp/connection/authconnection.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  static String username = "";
  String pwd = "";

  Future<bool> signIn(String username, String pwdTxt) async {
    Http http = Http();

    notifyListeners();
    return http.login(username, pwdTxt);
  }

  String getEmail() {
    return username;
  }

  setEmail(email) {
    username = email;
    notifyListeners();
  }
}
