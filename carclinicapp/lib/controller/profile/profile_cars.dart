import 'package:carclinicapp/controller/cars/add_cars.dart';
import 'package:carclinicapp/model/cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/auth.dart';

class ProfileCars extends StatefulWidget {
  const ProfileCars({Key? key}) : super(key: key);

  @override
  _ProfileCarsState createState() => _ProfileCarsState();
}

class _ProfileCarsState extends State<ProfileCars> {
  late Future<List> myFuture;

  @override
  Widget build(BuildContext context) {
    String email = context.watch<Auth>().getEmail();
    print("happy " + email);

    final Cars cars = Cars();
    myFuture = cars.getcars(email);

    return FutureBuilder(
        future: myFuture,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          List? content = snapshot.data;

          return Scaffold(
            floatingActionButton: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        // final Auth auth =
                        //     Provider.of<Auth>(context, listen: false);
                        // auth.setEmail(email);
                        return const RegisterCar();
                      },
                    ))),
            body: snapshot.hasData
                ? ListView.builder(
                    itemCount: content!.length,
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.car_repair),
                            title: Text(content[index]['brand']),
                          ),
                          Text("Model: " + content[index]['model']),
                          Text("Car Reg: " + content[index]['carReg']),
                          Text("year: " + content[index]['year']),
                          Text("Vin Number: " + content[index]['vinNumber']),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('Quick Book'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                child: const Text('Request A Quote'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No available cars"),
                  ),
          );
        });
  }
}
