import 'package:carclinicapp/model/auth.dart';
import 'package:carclinicapp/view/auth/register.dart';
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

  RegExp regExp = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/logo.png",height: 160,),
      ),
      Expanded(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SizedBox(
                    width: 250,
                    child: _buildTextField(
                        icon: const Icon(Icons.email_outlined),
                        labelText: "email",
                        validateMessage: "Please enter your username",
                        textController: userController)),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: SizedBox(
                    width: 250,
                    child: _buildTextField(
                        icon: const Icon(Icons.key),
                        labelText: "password",
                        validateMessage: "Please enter your password",
                        textController: passwordController,
                        showIcon: true)),
              ),
              const SizedBox(
                height: 20,
              ),
              button(context),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text("Forgot password?")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  InkWell(
                      child: const Text(
                        'register',
                        style: TextStyle(color: Colors.green),
                      ),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterWidget()),
                          )),
                ],
              )
            ],
          ),
        ),
      ),
    ]));
  }

  SizedBox button(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 35,
      child: ElevatedButton(
        onPressed: () async {
          // Validate will return true if the form is valid, or false if
          // the form is invalid.
          final Auth auth = Provider.of<Auth>(context, listen: false);
          if (_formKey.currentState!.validate()) {
            Future<bool> exist =
                auth.signIn(userController.text, passwordController.text);
            auth.setEmail(userController.text);
            if (await exist) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.black,
                elevation: 200.0,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  "wrong password/username",
                  style: TextStyle(color: Colors.red),
                ),
              ));
            }
          }
        },
        child: const Center(child: Text('Sign in')),
        style: ElevatedButton.styleFrom(primary: Colors.green),
      ),
    );
  }

  TextFormField _buildTextField(
      {required Icon icon,
      String labelText = '',
      String validateMessage = '',
      required TextEditingController textController,
      bool showIcon = false}) {
    return TextFormField(
      controller: textController,
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      obscureText: showIcon ? _isObscure : false,
      decoration: InputDecoration(
          prefixIcon: icon,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
          fillColor: Colors.red,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(134, 8, 31, 9),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(134, 8, 31, 9),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(166, 17, 105, 9),
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          suffixIcon: Visibility(
            child: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
            visible: showIcon,
          )),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validateMessage;
        } else if (!regExp.hasMatch(value) && showIcon == false) {
          return "invalid email";
        }
        return null;
      },
    );
  }
}
