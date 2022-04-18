import 'package:flutter/cupertino.dart';

import '../connection/qoute.dart';

class Quote extends ChangeNotifier {
  String email = "";
  Http http = Http();


  void createQoute({required String email, required String description}) {
    http.createQoute(email: email, description: description);
  }

   Future<List> getQuotes(String email) async {
    Http http = Http();

    return http.getQuotes(email);
  }
}
