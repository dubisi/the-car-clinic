import 'package:carclinicapp/controller/book/cofrim_book.dart';
import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/available_date.dart';
import 'package:carclinicapp/model/qoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuotesController extends StatefulWidget {
  const QuotesController({Key? key}) : super(key: key);

  @override
  _QuotesControllerState createState() => _QuotesControllerState();
}

class _QuotesControllerState extends State<QuotesController> {
  late Future<List> myFuture;

  @override
  Widget build(BuildContext context) {
    String email = context.watch<Auth>().getEmail();
    print("happy " + email);

    final Quote quote = Provider.of<Quote>(context, listen: false);
    myFuture = quote.getQuotes(email);

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
                onPressed: () {
                  Navigator.pushNamed(context, '/quote');
                },
                icon: const Icon(Icons.add)),
            body: snapshot.hasData
                ? ListView.builder(
                    itemCount: content!.length,
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.receipt_long),
                            trailing: Text(content[index]["status"]),
                          ),
                          Text("Car: " + content[index]['car']),
                          // Text("location: " + content[index]['location']),
                          Text("description: " + content[index]['description']),
                          // Text("price: " + content[index]["price"]),
                          // Text("details: " + content[index]["details"]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              const SizedBox(width: 8),
                              TextButton(
                                child: const Text('View Details'),
                                onPressed: () {
                                  show(
                                      email: email,
                                      details: content[index]['details'],
                                      price: content[index]['price'],
                                      car: content[index]['car']);
                                },
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const Text("No available orders"),
          );
        });
  }

  show(
      {String email = '',
      String details = '',
      String price = '',
      String car = ''}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: const EdgeInsets.only(top: 10),
            title: const Text('Overview'),
            content: Column(
              // ignore: prefer_if_null_operators, unnecessary_null_comparison
              children: [
                Text('details : ${details == null ? 'pending' : details}'),
                Text('price : $price'),
                Text('requested service : $price')
              ],
            ),
            actions: [
              TextButton(onPressed: () {}, child: const Text('Reject')),
              TextButton(
                  onPressed: () {
                    final Dates dates =
                        Provider.of<Dates>(context, listen: false);
                    dates.init(service: details, price: price, carReg: car);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CofirmBook()),
                    );
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }
}
