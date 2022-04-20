import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../connection/date.dart';

class Dates with ChangeNotifier, DiagnosticableTreeMixin {
  String _service = "";
  String _price = "";
  String _carReg = "";

  String? get service => _service;

  String? get labour => _price;

  String? get carReg => _carReg;

  init(
      {required String service,
      required String price,
      required String carReg}) {
    _service = service;
    _price = price;
    _carReg = carReg;
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
    properties.add(StringProperty('carReg', carReg));
  }
}
