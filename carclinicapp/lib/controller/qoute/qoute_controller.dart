import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/cars.dart';
import 'package:carclinicapp/model/qoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteController extends StatefulWidget {
  const QuoteController({Key? key}) : super(key: key);

  @override
  _QouteControllerState createState() => _QouteControllerState();
}

class _QouteControllerState extends State<QuoteController> {
  late Quote qoute;
  late Future<List> myFuture;
  List<String> carList = ["Select Car"];
  String? value = "Select Car";

  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    qoute = Quote();
  }

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
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 259,
                          child: _buildTextField(),
                        ),
                        const SizedBox(height: 15),
                        _buildTextButton(context, email)
                      ],
                    ),
                  ),
                )
              ]),
            ),
          );
        });
  }

  TextField _buildTextField() {
    return TextField(
      controller: description,
      maxLines: 10,
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      decoration: const InputDecoration(
        labelText: 'problem',
        labelStyle: TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        fillColor: Colors.red,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
      ),
    );
  }

  TextButton _buildTextButton(context, String email) {
    return TextButton(
      onPressed: () => {
        qoute.createQoute(email: email, description: description.text),
        Navigator.pushReplacementNamed(context, '/orders')
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20.0),
        ),
        side:
            MaterialStateProperty.all(const BorderSide(color: Colors.black54)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: const Text(
        'Request',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }
}

List<String> convert(List<dynamic> content) {
  List<String> carsName = ["Select Car"];

  for (int i = 0; i < content.length; i++) {
    carsName.add(content[i]["brand"] +
        " " +
        content[i]["model"] +
        " " +
        content[i]["year"]);
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
