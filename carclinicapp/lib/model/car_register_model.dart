import 'package:carclinicapp/connection/cars.dart';
import 'package:flutter/cupertino.dart';

class CarRegister extends ChangeNotifier {
  String email = "";

  Future<bool> addCar(
      {required String brand,
      required String model,
      required String vinNumber,
      required String year,
      required String carRegistration,
      required String email}) async {
    Http http = Http();

    return http.addCars(
        brand: brand,
        model: model,
        vinNumber: vinNumber,
        year: year,
        carRegistration: carRegistration,
        email: email);
  }
}
