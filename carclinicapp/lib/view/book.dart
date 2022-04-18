import 'package:carclinicapp/controller/book/book_form.dart';
import 'package:flutter/material.dart';

class BookService extends StatelessWidget {
  const BookService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quick Book"),
        backgroundColor: Colors.green,
      ),
      body: const Center(child: BookForm()),
    );
  }
}
