import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/view/auth/register.dart';
import 'package:carclinicapp/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Padding(
        padding: EdgeInsets.all(48.0),
        child: Text("THE CAR CLINIC"),
      ),
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: userController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email_outlined),
                    hintText: 'Enter your email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  final Auth auth = Provider.of<Auth>(context, listen: false);
                  if (_formKey.currentState!.validate()) {
                    Future<bool> exist = auth.signIn(
                        userController.text, passwordController.text);
                    auth.setEmail(userController.text);
                    if (true) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "wrong password/username",
                          style: TextStyle(color: Colors.red),
                        ),
                      ));
                    }
                  }
                },
                child: const Text('Sign in'),
              ),
            ),
          ],
        ),
      ),
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: Text("Forgot password?")),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          InkWell(
              child: const Text(
                'register',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterWidget()),
                  )),
        ],
      ),
    ]));
  }
}
