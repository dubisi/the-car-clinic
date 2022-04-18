import 'package:carclinicapp/connection/cars.dart';
import 'package:flutter/cupertino.dart';

class CarRegister extends ChangeNotifier {
  String email = "";

  Future<bool> addCar(String brand, String model, vinNumber, year, carRegister,
      location, email) async {
    Http http = Http();

    return http.addCars(
        brand, model, vinNumber, year, carRegister, location, email);
  }
}
