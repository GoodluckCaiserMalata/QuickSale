import 'package:quicksale/services/auth.dart';
import 'package:quicksale/views/shop_views_screen/index.views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quicksale/services/notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 500),
            height: 490,
            child: Image.asset("assets/images/authrec.png", fit: BoxFit.cover),
          ),
          Container(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    padding: EdgeInsets.only(top: 230),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'MartelSans'),
                    ),
                  )
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      padding: EdgeInsets.only(top: 230),
                      child: SizedBox(
                        width: 320,
                        child: SignUpForm(),
                      )),
                ]),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class SignUpFormState extends State<SignUpForm> {
  final Notifications notification = Notifications(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      selectNotificationSubject: selectNotificationSubject,
      platform: platform);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error = '';

  String name = '';
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    notification.initState(notification.selectNotificationSubject,
        notification.selectedNotificationPayload);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
                prefixIcon: Icon(Icons.person_outlined, size: 22),
                hintText: 'Name'),
          ),

          // The validator receives the text that the user has entered.
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: TextFormField(
              validator: (val) => val.isEmpty ? 'Enter a mail' : null,
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
                  prefixIcon: Icon(Icons.email_outlined, size: 22),
                  hintText: 'Email'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 10),
            child: TextFormField(
              validator: (val) =>
                  val.length < 6 ? 'Enter a password +6 chars length' : null,
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
              obscureText: true,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'MartelSans'),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outlined, size: 22),
                  suffixIcon: Icon(Icons.remove_red_eye_sharp, size: 22),
                  hintText: 'Password'),
            ),
          ),

          Row(children: [
            Container(
              width: 320,
              child: ElevatedButton(
                child: Text("Sign Up"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password, name);

                    if (result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                      });
                    } else {
                      print(result);
                      notification.showNotification('QuickSale', 
                          'You have been successfully registered!',
                          'Closed');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Shop()));
                    }
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
