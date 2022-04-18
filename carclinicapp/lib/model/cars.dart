import 'package:carclinicapp/connection/cars.dart';
import 'package:flutter/cupertino.dart';

class Cars extends ChangeNotifier {
  String email = "";

  Future<List> getcars(email) async {
    Http http = Http();

    return http.getCars(email);
  }

  setEmail(em) {
    email = em;
  
  }

  getEmail() {
    return email;
  }
}
