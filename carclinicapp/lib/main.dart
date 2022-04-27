import 'package:carclinicapp/controller/book/services.dart';
import 'package:carclinicapp/controller/bottom_navbar/layout.dart';
import 'package:carclinicapp/controller/profile/edit_profile.dart';
import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/available_date.dart';
import 'package:carclinicapp/model/book.dart';
import 'package:carclinicapp/model/car_register_model.dart';
import 'package:carclinicapp/model/cars.dart';
import 'package:carclinicapp/model/qoute.dart';
import 'package:carclinicapp/model/register.dart';
import 'package:carclinicapp/view/auth/login.dart';
import 'package:carclinicapp/view/book.dart';
import 'package:carclinicapp/view/orders.dart';
import 'package:carclinicapp/view/profile.dart';
import 'package:carclinicapp/view/qoute.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Auth()),
      ChangeNotifierProvider(create: (_) => Register()),
      ChangeNotifierProvider(create: (_) => Cars()),
      ChangeNotifierProvider(create: (_) => CarRegister()),
      ChangeNotifierProvider(create: (_) => Services()),
      ChangeNotifierProvider(create: (_) => Dates()),
      ChangeNotifierProvider(create: (_) => Book()),
      ChangeNotifierProvider(create: (_) => Quote())
    ],
    child: const TheCarClinic(),
  ));
}

class TheCarClinic extends StatelessWidget {
  const TheCarClinic({Key? key}) : super(key: key);
  static const String _title = 'The Car Clinic';
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.green)),
      title: _title,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginWidget(),
        '/home': (context) => const Home(),
        '/orders': ((context) => const Orders()),
        '/profile': (context) => const Profile(),
        '/edit_profile': (context) => const EditProfile(),
        '/book': (context) => const BookService(),
        '/quote': (context) => const QouteWidget()
      },
    );
  }
}
