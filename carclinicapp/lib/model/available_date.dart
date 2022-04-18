import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../connection/date.dart';

class Dates with ChangeNotifier, DiagnosticableTreeMixin {
  String _email = "";
  String _service = "";
  String _price = "";
  String _car = "";


  String? get service => _service;

  String? get email => _email;

  String? get labour => _price;

  String? get car => _car;

  init(email, service, price, car) {
    _email = email;
    _service = service;
    _price = price;
    _car = car;
    notifyListeners();
  }

  Future<List> getAvailableDates() async {
    Http http = Http();

    return http.getDates();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('service', service));
    properties.add(StringProperty('labourPrice', labour));
    properties.add(StringProperty('car', car));
    properties.add(StringProperty('email', email));
  }
}
