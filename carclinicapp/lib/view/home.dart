import 'package:carclinicapp/model/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String email = "";
  @override
  Widget build(BuildContext context) {
    email = context.watch<Auth>().getEmail();
    print("hgghf" + email);
    return DefaultTabController(
        length: 1,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.green,
                  expandedHeight: 200,
                  title: const Center(child: Text("The Car Clinic")),
                  actions: const [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 2,
                    )
                  ],
                  // flexibleSpace: AppBar(title: const Text("shit")),
                  bottom: TabBar(
                    indicatorColor: Colors.green,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            onPressed: () {
                              Navigator.pushNamed(context, "/book");
                            },
                            child: const Text("Quick Booking")),
                      )
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: [
                Center(child: Image.asset('assets/images/HOWit.png')),
                // Center(child: Text("services"))
              ],
            )));
  }
}
