import 'package:quicksale/views/shop_views_screen/index.views.dart';
import 'package:flutter/material.dart';
import 'package:quicksale/services/auth.dart';
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 500),
          height: 500,
          child: Image.asset("assets/images/authrec.png", fit: BoxFit.cover),
        ),
        Container(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.only(top: 250),
                  child: Text(
                    'Welcome Back',
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
                      child: LoginForm(),
                    )),
              ]),
            ],
          ),
        )
      ],
    )));
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  final Notifications notification = Notifications(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      selectNotificationSubject: selectNotificationSubject,
      platform: platform);

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
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
            validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
          // The validator receives the text that the user has entered.

          Padding(
            padding: const EdgeInsets.only(top: 5),
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

          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                'Forgot your password?',
                style: TextStyle(
                    color: Color(0xFF9BA9FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans'),
              ),
            )
          ]),

          Row(children: [
            Container(
              width: 320,
              child: ElevatedButton(
                child: Text("Log in"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);

                    if (result == null) {
                      setState(() {
                        error = 'error with login credentials';
                      });
                    } else {
                      print(result);
                      notification.showNotification('QuickSale', 
                          'Successfull Login! Welcome back!',
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
