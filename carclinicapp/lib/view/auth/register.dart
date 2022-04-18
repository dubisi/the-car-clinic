import 'dart:io';

import 'package:carclinicapp/model/register.dart';
import 'package:carclinicapp/view/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Padding(
        padding: EdgeInsets.all(48.0),
        child: Text("REGISTER"),
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
                  child: _buildTextField(
                      labelText: 'Name',
                      validateMessage: 'Please enter your name',
                      textController: nameController)),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  child: _buildTextField(
                      labelText: 'Surname',
                      validateMessage: 'Please enter your surname',
                      textController: surnameController)),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  child: _buildTextField(
                      labelText: 'Mobile Number',
                      validateMessage: 'Please enter your mobile number',
                      textController: numberController)),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  child: _buildTextField(
                      labelText: 'Enter your email',
                      validateMessage: 'Please enter your email',
                      textController: emailController)),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  child: _buildTextField(
                      labelText: 'location',
                      validateMessage: 'Please enter your location',
                      textController: emailController)),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  child: _buildPasswordTextField(
                      labelText: 'Password',
                      validateMessage: 'Please enter your password',
                      textController: password1Controller)),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  child: _buildPasswordTextField(
                      labelText: 'Confirm password',
                      validateMessage: 'Please confirm your password',
                      textController: password2Controller)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  final Register register =
                      Provider.of<Register>(context, listen: false);
                  if (_formKey.currentState!.validate()) {
                    Future<bool> exist = register.register(
                        nameController.text,
                        surnameController.text,
                        numberController.text,
                        emailController.text,
                        password1Controller.text);
                    if (await exist) {
                      Navigator.pushNamed(context, "/");
                    } else {
                      const Text("user already exists");
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Already have account?"),
          InkWell(
              child: const Text(
                'Log In',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginWidget()),
                  )),
        ],
      ),
    ])));
  }

  TextFormField _buildTextField(
      {String labelText = '',
      String validateMessage = '',
      required TextEditingController textController}) {
    return TextFormField(
      controller: textController,
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        fillColor: Colors.red,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validateMessage;
        }
        return null;
      },
    );
  }

  TextFormField _buildPasswordTextField(
      {String labelText = '',
      String validateMessage = '',
      required TextEditingController textController}) {
    return TextFormField(
      controller: textController,
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 18.0,
        ),
        fillColor: Colors.red,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return validateMessage;
        }
        return null;
      },
    );
  }
}
