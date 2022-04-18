import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/car_register_model.dart';
import 'package:carclinicapp/model/cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterCar extends StatefulWidget {
  const RegisterCar({Key? key}) : super(key: key);

  @override
  _RegisterCarState createState() => _RegisterCarState();
}

class _RegisterCarState extends State<RegisterCar> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController vinNumberController = TextEditingController();
  TextEditingController carRegController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? email = "";

  @override
  Widget build(BuildContext context) {
    final Cars cars = Provider.of<Cars>(context, listen: false);

    email = context.watch<Auth>().getEmail();
    print('car ' + email!);
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.cancel_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text("Register your car"),
            backgroundColor: Colors.green),
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                          width: 250,
                          child: _buildTextField(
                              labelText: 'brand',
                              validateMessage: 'Please enter car brand',
                              textController: brandController)),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                          width: 250,
                          child: _buildTextField(
                              labelText: 'model',
                              validateMessage: 'Please enter car model',
                              textController: modelController)),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                          width: 250,
                          child: _buildTextField(
                              labelText: 'year',
                              validateMessage: 'Please enter car year',
                              textController: yearController)),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                          width: 250,
                          child: _buildTextField(
                              labelText: 'vin number',
                              validateMessage: 'Please enter vin number',
                              textController: vinNumberController)),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                          width: 250,
                          child: _buildTextField(
                              labelText: 'car reg',
                              validateMessage: 'Please enter your car reg',
                              textController: carRegController)),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                          width: 250,
                          child: _buildTextField(
                              labelText: 'location',
                              validateMessage: 'Please enter your location',
                              textController: locationController)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () async {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          final CarRegister carRegister =
                              Provider.of<CarRegister>(context, listen: false);
                          if (_formKey.currentState!.validate()) {
                            Future<bool> exist = carRegister.addCar(
                                brandController.text,
                                modelController.text,
                                yearController.text,
                                vinNumberController.text,
                                carRegController.text,
                                locationController.text,
                                email);
                            if (await exist) {
                              Navigator.pushReplacementNamed(
                                  context, "/profile");
                            } else {
                              const Text("please try again");
                            }
                          }
                        },
                        child: const Text('add'),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  TextFormField _buildTextField(
      {String labelText = '',
      String validateMessage = '',
      required TextEditingController textController}) {
    return TextFormField(
      controller: textController,
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        fillColor: Colors.red,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validateMessage;
        }
        return null;
      },
    );
  }
}
