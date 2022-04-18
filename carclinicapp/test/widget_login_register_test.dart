import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/model/register.dart';
import 'package:carclinicapp/view/auth/login.dart';
import 'package:carclinicapp/view/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('login page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Auth()),
            ChangeNotifierProvider(create: (_) => Register()),
          ],
          child: Builder(
            builder: (_) => const LoginWidget(),
          ),
        )));
    ;
    await tester.pumpWidget(testWidget);

    //expected to be found on the login page
    expect(find.text('THE CAR CLINIC'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Tap the 'Sign in' button and trigger a frame.
    await tester.tap(find.text("Sign in"));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify that our validation works
    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    expect(find.text('Forgot password?'), findsOneWidget);
    expect(find.text('Don\'t have an account? '), findsOneWidget);
    expect(find.text('register'), findsOneWidget);
  });

  testWidgets('register page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
            home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => Auth()),
            ChangeNotifierProvider(create: (_) => Register()),
          ],
          child: Builder(
            builder: (_) => const RegisterWidget(),
          ),
        )));
    await tester.pumpWidget(testWidget);

    //expected to be found on the login page
    expect(find.text('REGISTER'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Surname'), findsOneWidget);
    expect(find.text('Mobile Number'), findsOneWidget);
    expect(find.text('Enter your email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Confirm password'), findsOneWidget);

    // Tap the 'Sign UP' button and trigger a frame.
    await tester.tap(find.text("Sign Up"));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify that our validation works
    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your surname'), findsOneWidget);
    expect(find.text('Please enter your mobile number'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);

    expect(find.text('Already have account?'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });
}
