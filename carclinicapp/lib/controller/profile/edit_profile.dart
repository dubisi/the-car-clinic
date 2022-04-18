import 'dart:io';

import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';

import '../../view/home.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _profilePicFile = File('');

  @override
  void initState() {
    super.initState();
  }

  // A simple usage of EditableImage.
  // This method gets called when trying to change an image.
  void _directUpdateImage(File? file) async {
    if (file == null) return;

    _profilePicFile = file;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel)),
          title: const Text('Profile Settings')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Spacer(flex: 2),
              Center(
                child: EditableImage(
                  // Define the method that will run on the change process of the image.
                  onChange: (file) => _directUpdateImage(file),

                  // Define the source of the image.
                  image: _profilePicFile.existsSync()
                      ? Image.file(_profilePicFile, fit: BoxFit.cover)
                      : null,

                  // Define the size of EditableImage.
                  size: 150.0,

                  // Define the Theme of image picker.
                  imagePickerTheme: ThemeData(
                    // Define the default brightness and colors.
                    primaryColor: Colors.white,
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.white70,
                    iconTheme: const IconThemeData(color: Colors.black87),

                    // Define the default font family.
                    fontFamily: 'Georgia',
                  ),

                  // Define the border of the image if needed.
                  imageBorder: Border.all(color: Colors.black87, width: 2.0),

                  // Define the border of the icon if needed.
                  editIconBorder: Border.all(color: Colors.black87, width: 2.0),
                ),
              ),
              const SizedBox(height: 15),
              _buildTextField(labelText: 'Username'),
              const SizedBox(height: 15),
              _buildTextField(labelText: 'Full Name'),
              const SizedBox(height: 15),
              _buildTextField(labelText: 'Email'),
              const SizedBox(height: 15),
              _buildTextField(labelText: 'Password', obscureText: true),
              const SizedBox(height: 15),
              _buildTextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  TextField _buildTextField({String labelText = '', bool obscureText = false}) {
    return TextField(
      cursorColor: Colors.black54,
      cursorWidth: 1.0,
      obscureText: obscureText,
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
            Radius.circular(40.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(40.0),
          ),
        ),
      ),
    );
  }

  TextButton _buildTextButton(context) {
    return TextButton(
      onPressed: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "The Car Clinic")),
        )
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20.0),
        ),
        side:
            MaterialStateProperty.all(const BorderSide(color: Colors.black54)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
