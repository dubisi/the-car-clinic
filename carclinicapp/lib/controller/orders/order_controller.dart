import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersController extends StatefulWidget {
  const OrdersController({Key? key}) : super(key: key);

  @override
  _OrdersControllerState createState() => _OrdersControllerState();
}

class _OrdersControllerState extends State<OrdersController> {
  late Future<List> myFuture;

  @override
  Widget build(BuildContext context) {
    String email = context.watch<Auth>().getEmail();
    print("happy " + email);

    final Book book = Provider.of<Book>(context, listen: false);
    myFuture = book.getBookings(email);

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
                  Navigator.pushNamed(context, '/book');
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
                          Text("location: " + content[index]['location']),
                          Text("description: " + content[index]['description']),
                          Text("price: " + content[index]["price"]),
                          // Text("details: " + content[index]["details"]),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No available orders"),
                  ),
          );
        });
  }
}
