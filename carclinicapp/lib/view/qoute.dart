import 'package:carclinicapp/controller/qoute/qoute_controller.dart';
import 'package:flutter/material.dart';

class QouteWidget extends StatefulWidget {
  const QouteWidget({Key? key}) : super(key: key);

  @override
  State<QouteWidget> createState() => _QouteWidgetState();
}

class _QouteWidgetState extends State<QouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            title: const Text("Request Quote")),
        body: const Center(child: QuoteController()));
  }
}
