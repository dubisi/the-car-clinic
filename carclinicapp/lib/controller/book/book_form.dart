import 'package:carclinicapp/controller/book/cofrim_book.dart';
import 'package:carclinicapp/controller/book/services.dart';
import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/available_date.dart';
import 'package:carclinicapp/model/cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class BookForm extends StatefulWidget {
  const BookForm({Key? key}) : super(key: key);

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  late Future<List> myFuture;
  List<String> carList = ["Select Car"];
  String? value = "Select Car";

  String service = "";

  List<S2Choice<String>> options = [
    S2Choice<String>(
        value: 'oil',
        title: 'Oil & Filter',
        meta: const Icon(Icons.access_alarm)),
    S2Choice<String>(value: 'pads', title: 'Brake pads'),
    S2Choice<String>(value: 'clutch', title: 'Clutch Services'),
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Cars cars = Provider.of<Cars>(context, listen: false);
    String email = context.watch<Auth>().getEmail();
    print('object' + email);
    myFuture = cars.getcars(email);
    return FutureBuilder(
        future: myFuture,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          List? content = snapshot.data;
          if (!snapshot.hasData) {
            carList.add("No avalable Cars");
            return const Center(
              child: Text("No available cars"),
            );
          } else {
            carList = convert(content!);
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
                        value: value,
                        isExpanded: true,
                        items: carList.map(buildMenuItem).toList(),
                        onChanged: (value) =>
                            setState(() => this.value = value),
                        validator: (value) {
                          if (value == "Select Car" || value!.isEmpty) {
                            return 'Please select car';
                          }
                          return null;
                        }),
                  ),
                ),
                SmartSelect<String>.single(
                    modalType: S2ModalType.popupDialog,
                    choiceLayout: S2ChoiceLayout.grid,
                    modalConfirm: true,
                    title: 'Services',
                    value: service,
                    choiceItems: options,
                    onChange: (state) => {
                          service = context
                              .read<Services>()
                              .serviceGenerate(state.valueDisplay)
                        }),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // context.read<Services>().serviceGenerate(service),
                        const Text('Cost Summary'),
                        ListTile(
                          leading: const Text("Labour Charge"),
                          trailing: Text(context.watch<Services>().labour),
                        ),
                        ListTile(
                          leading: Text(context.watch<Services>().parts),
                          trailing: Text(context.watch<Services>().partsPrice),
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
                      final Dates dates =
                          Provider.of<Dates>(context, listen: false);
                      if (_formKey.currentState!.validate()) {
//                   // If the form is valid, display a snackbar. In the real world,
//                   // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        dates.init(
                            service: service,
                            price: context.watch<Services>().labour,
                            carReg: value!.split(" ")[4]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CofirmBook()),
                        );
                      }
                    },
                    child: const Text('Proceed'),
                  ),
                ),
              ],
            ),
          ));
        });
  }
}

List<String> convert(List<dynamic> content) {
  List<String> carsName = ["Select Car"];

  for (int i = 0; i < content.length; i++) {
    carsName.add(content[i]["brand"] +
        " " +
        content[i]["model"] +
        " " +
        content[i]["year"] +
        " " +
        content[i]["carReg"]);
  }
  return carsName;
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
