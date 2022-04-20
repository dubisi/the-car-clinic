import 'package:flutter/cupertino.dart';

import '../connection/book.dart';

class Book extends ChangeNotifier {
  String email = "";

  Future<void> book(
      {required String carReg,
      required String service,
      required String price,
      required String date}) async {
    Http http = Http();

    http.book(carReg: carReg, service: service, date: date, price: price);
  }

  Future<List> getBookings(String email) async {
    Http http = Http();

    return http.getBookings(email);
  }
}
