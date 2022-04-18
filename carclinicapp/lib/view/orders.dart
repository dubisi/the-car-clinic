
import 'package:carclinicapp/controller/orders/order_controller.dart';
import 'package:carclinicapp/controller/orders/quotes_controller.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              const SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Colors.green,
                // expandedHeight: 200,
                title: Text("Orders"),

                // flexibleSpace: AppBar(title: const Text("shit")),
                bottom: TabBar(
                  indicatorColor: Colors.green,
                  tabs: [
                    Text("Quick Bookings"),
                    Text("Qoutes"),
                  ],
                ),
              )
            ];
          },
          body: const TabBarView(
            children: [
              Center(child: OrdersController()),
              Center(child: QuotesController())
            ],
          ),
        ));
  }
}
