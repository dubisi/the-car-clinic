import 'package:carclinicapp/controller/book/book_form.dart';
import 'package:carclinicapp/controller/book/services.dart';
import 'package:carclinicapp/view/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/available_date.dart';
import '../../model/book.dart';

class CofirmBook extends StatefulWidget {
  const CofirmBook({Key? key}) : super(key: key);

  @override
  _CorfirmBookState createState() => _CorfirmBookState();
}

class _CorfirmBookState extends State<CofirmBook> {
  late Future<List> myFuture;
  List<String> datesList = ["Select date"];
  String date = "Select Date";
  String service = '';
  String labour = '';
  String carReg = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    service = context.watch<Dates>().service!;
    labour = context.watch<Dates>().labour!;
    carReg = context.watch<Dates>().carReg!;

    print("bjgjgj"+service);

    final Dates dates = Provider.of<Dates>(context, listen: false);
    myFuture = dates.getAvailableDates();
    return FutureBuilder(
        future: myFuture,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          List? content = snapshot.data;
          if (!snapshot.hasData) {
            datesList.add("No avalable dates");
            return const Center(
              child: Text("No available dates"),
            );
          } else {
            datesList = convertDate(content!);
          }
          return Scaffold(
              body: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField<String>(
                        value: date,
                        isExpanded: true,
                        items: datesList.map(buildMenuItem).toList(),
                        onChanged: (value) => setState(() {
                              date = value!;
                              // dates.init(email, service, labour, carReg);
                            }),
                        validator: (value) {
                          if (value == "Select date" || value!.isEmpty) {
                            return 'Please select date';
                          }
                          return null;
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        // context.read<Services>().serviceGenerate(value1),
                        Text('Cost Summary'),
                        ListTile(
                          leading: Text("tembisa"),
                          trailing: Text("1632"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
//                 // Validate returns true if the form is valid, or false otherwise.
                      final Book bookService =
                          Provider.of<Book>(context, listen: false);
                      if (_formKey.currentState!.validate()) {
//                   // If the form is valid, display a snackbar. In the real world,
//                   // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        bookService.book(
                            carReg: carReg,
                            service: service,
                            price: labour,
                            date: date);
                        Navigator.pushReplacementNamed(context, "/orders");
                      }
                    },
                    child: const Text('Book'),
                  ),
                ),
              ],
            ),
          ));
        });
  }

  List<String> convertDate(List<dynamic> content) {
    List<String> dates = ["Select Date"];

    for (int i = 0; i < content.length; i++) {
      dates.add(content[i]["date"]);
    }
    return dates;
  }
}
