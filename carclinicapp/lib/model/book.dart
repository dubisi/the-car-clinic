import 'package:flutter/cupertino.dart';

import '../connection/book.dart';

class Book extends ChangeNotifier {
  String email = "";

  Future<void> book(email, service, price, date, car) async {
    Http http = Http();

    http.book(email, service, date, price, car);
  }

  Future<List> getBookings(String email) async {
    Http http = Http();

    return http.getBookings(email);
  }
}
