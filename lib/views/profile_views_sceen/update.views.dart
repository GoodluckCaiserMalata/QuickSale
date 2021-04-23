import 'package:flutter/material.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/models/product.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:quicksale/services/storage.dart';

class UpdateItem extends StatelessWidget {
  final Product product;

  UpdateItem(this.product);

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
            title: Text('Update Item',
                style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
          ),
          body: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.only(top: 40, right: 20, left: 20),
            child: Column(
              children: [
                ImageUploader(product),

                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 300,
                  child: UpdateItemForm(product),
                )
              ],
            ),
          ),
    )));
  }
}

class ImageUploader extends StatefulWidget {
  final Product product;

  ImageUploader(this.product);
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
    // final user = context.watch<UserModel>();
    // final userData = context.watch<UserData>();
    final Storage storage = Storage(documentID: widget.product.id);

    return Container(
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image(
              image: NetworkImage(widget.product.photoURL),
              fit: BoxFit.contain,
            ),
          ),
          TextButton(
              onPressed: () async {
                await _showChoiceDialog(context);

                if (isSelected == true) {
                  await storage.uploadImageProductToFirebase(imageFile);
                }

                setState(() {
                  isDone = true;
                });
              },
              child: Text('Upload Image',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Color(0xFF9BA9FF)))),
        ],
      ),
    );
  }
}

class UpdateItemForm extends StatefulWidget {
  final Product product;

  UpdateItemForm(this.product);
  @override
  UpdateItemFormState createState() {
    return UpdateItemFormState();
  }
}

class UpdateItemFormState extends State<UpdateItemForm> {
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String title = '';
  String price = '';
  String priceDelivery = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final userData = context.watch<UserData>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (val) => val.isEmpty ? 'Enter a title' : null,
            onChanged: (val) {
              setState(() {
                title = val;
              });
            },
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                fontFamily: 'MartelSans'),
            decoration: InputDecoration(
              hintText: widget.product.title,
              labelText: 'Title',
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
              validator: (val) => val.isEmpty ? 'Enter a valid price' : null,
              onChanged: (val) {
                setState(() {
                  price = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: widget.product.price,
                labelText: 'Price',
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
              validator: (val) => val.isEmpty ? 'Enter a valid price' : null,
              onChanged: (val) {
                setState(() {
                  priceDelivery = val;
                });
              },
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: widget.product.priceDelivery,
                labelText: 'Delivery Price',
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

          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a description' : null,
              onChanged: (val) {
                setState(() {
                  description = val;
                });
              },
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                hintText: widget.product.description,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Description',
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

          Row(children: [
            Container(
              width: 300,
              child: ElevatedButton(
                child: Text("Update Item"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await DatabaseService(documentId: widget.product.id)
                        .updateProductData(
                            title,
                            widget.product.photoURL,
                            price,
                            priceDelivery,
                            userData.uid,
                            userData.name,
                            description);

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
