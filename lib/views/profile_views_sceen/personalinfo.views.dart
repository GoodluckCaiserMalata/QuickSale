import 'package:flutter/material.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/auth.dart';
import 'package:quicksale/services/database.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:quicksale/services/storage.dart';

class PersonalInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserData>.value(
        value: DatabaseService(documentId: user.uid).userData,
        initialData: UserData('', '', '', '', '', '', '', ''),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.grey),
              elevation: 1,
              centerTitle: true,
              title: Text('Personal Information',
                  style:
                      TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20, right: 40, left: 40),
                child: Column(
                  children: [
                    ImageUploader(),
                    Container(
                      child: InfoForm(),
                    )
                  ],
                ),
              ),
            )));
  }
}

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File imageFile;
  bool isSelected = false;
  bool isDone = false;

  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Color(0xFF9BA9FF)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xFF9BA9FF),
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xFF9BA9FF),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xFF9BA9FF),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xFF9BA9FF),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = File(pickedFile.path);
      isSelected = true;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = File(pickedFile.path);
      isSelected = true;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();
    final userData = context.watch<UserData>();
    final Storage storage = Storage(documentID: user.uid);

    return Container(
        child: Container(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 120,
            child: Image(image: NetworkImage(userData.photoURL), fit: BoxFit.contain,),
          ),
          TextButton(
              onPressed: () async {
                await _showChoiceDialog(context);

                if(isSelected == true){
                  await storage.uploadImageUserToFirebase(imageFile);
                }
              
                setState(() {
                  isDone = true;
                });
              },
              child: Text('Upload Image',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Color(0xFF9BA9FF))))
        ],
      ),
    ));
  }
}

class InfoForm extends StatefulWidget {
  @override
  InfoFormState createState() {
    return InfoFormState();
  }
}

class InfoFormState extends State<InfoForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '';
  String name = '';
  String dateofbirth = '';
  String email = '';
  String occupation = '';
  String phoneNumber = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserData>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter a name' : null,
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                fontFamily: 'MartelSans'),
            decoration: InputDecoration(
              hintText: userData.name,
              labelText: 'Name',
              labelStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
              ),
            ),
          ),
          // The validator receives the text that the user has entered.

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a dateofbirth' : null,
              onChanged: (val) {
                setState(() {
                  dateofbirth = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: userData.dateofbirth,
                labelText: 'Date of Birth',
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Enter occupation' : null,
              onChanged: (val) {
                setState(() {
                  occupation = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: userData.occupation,
                labelText: 'Occupation',
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a valid email' : null,
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: userData.email,
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Enter a valid phone number' : null,
              onChanged: (val) {
                setState(() {
                  phoneNumber = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: userData.phonenumber,
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a gender' : null,
              onChanged: (val) {
                setState(() {
                  gender = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: userData.gender,
                labelText: 'Gender',
                labelStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300], width: 0.5),
                ),
              ),
            ),
          ),

          Row(children: [
            Container(
              width: 300,
              child: ElevatedButton(
                child: Text("Update Profile"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await DatabaseService(documentId: userData.uid)
                        .updateUserData(name, email, userData.photoURL,
                            dateofbirth, occupation, phoneNumber, gender);

                    await _auth.auth.currentUser
                        .updateProfile(displayName: name);
                    await _auth.auth.currentUser.updateEmail(email);
                    final snackBar = SnackBar(
                      content: Text('Updated Successfully'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
