import 'package:quicksale/services/notification.dart';
import 'package:quicksale/views/onboarding_views_screen/index.views.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Notifications notification = Notifications(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      selectNotificationSubject: selectNotificationSubject,
      platform: platform);

  @override
  void initState() {
    super.initState();
    notification.initState(notification.selectNotificationSubject,
        notification.selectedNotificationPayload);

    notification.showNotification('QuickSale', 'Welcome to QuickSale!', 'Closed');
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OnBoarding())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Background.png"),
                fit: BoxFit.cover),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Image.asset("assets/images/Logo.png",
                              width: 400, height: 100, fit: BoxFit.cover)))
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "v.1.0",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'MartelSans'),
                  )),
            )
          ],
        )
      ]),
    );
  }
}
