import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Services with ChangeNotifier, DiagnosticableTreeMixin {
  List<Map<String, String>> price = [
    {
      "parts": "Engine Oil & Filter",
      "labour": "R 400.00",
      "service": "Oil & Filter"
    },
    {"parts": "Brake pads", "labour": "R 600.00", "service": "Brake pads"},
    {"parts": "Clutch Kits", "labour": "R 400.00", "service": "Clutch Services"}
  ];

  final String _service = "";
  String _parts = "";
  String _partPrice = "";
  String _labourPrice = "-";

  String get labour => _labourPrice;
  String get service => _service;
  String get parts => _parts;
  String get partsPrice => _partPrice;

  serviceGenerate(String value) {
    String? prc;
    String? part;
    for (int i = 0; i < price.length; i++) {
      if (price[i]["service"] == value) {
        prc = price[i]["labour"];
        part = price[i]["parts"];
      }
    }
    _labourPrice = prc!;
    _parts = part!;
    _partPrice = "Coming Soon";
    notifyListeners();
    return value;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('service', service));
    properties.add(StringProperty('parts', parts));
    properties.add(StringProperty('partPrice', partsPrice));
    properties.add(StringProperty('labourPrice', labour));
  }
}
