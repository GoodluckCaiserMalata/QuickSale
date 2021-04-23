import 'package:flutter/material.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/database.dart';

class UploadItem extends StatelessWidget {
  final String url =
      'https://www.smallwoods.org.uk/assets/Uploads/Documents/ac72cd8e0a/product-default-img__FitMaxWzEwMDAsODAwXQ.jpg';

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
              title: Text('Upload Item',
                  style:
                      TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 40, right: 20, left: 20),
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Image(
                              image: NetworkImage(url),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: 300,
                      child: UploadItemForm(),
                    )
                  ],
                ),
              ),
            )));
  }
}

class UploadItemForm extends StatefulWidget {
  @override
  UploadItemFormState createState() {
    return UploadItemFormState();
  }
}

class UploadItemFormState extends State<UploadItemForm> {
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String title = '';
  String price = '';
  String priceDelivery = '';
  String description = '';
  String photoURL =
      'https://www.smallwoods.org.uk/assets/Uploads/Documents/ac72cd8e0a/product-default-img__FitMaxWzEwMDAsODAwXQ.jpg';

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
                child: Text("Add Item"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await DatabaseService(documentId: userData.uid)
                        .addProductData(
                            title,
                            photoURL,
                            price,
                            priceDelivery,
                            userData.uid,
                            userData.name,
                            description);
                    

                    final snackBar = SnackBar(
                      content: Text('Updated Successfully'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pop(context);
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
