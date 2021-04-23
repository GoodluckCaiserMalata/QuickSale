import 'package:flutter/material.dart';
import 'package:quicksale/services/auth.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/views/profile_views_sceen/settings.views.dart';

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


class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserData>.value(
        value: DatabaseService(documentId: user.uid).userData,
        initialData: UserData('', '', '', '', '', '', '', ''),
        child: Builder(builder: (context) {
          final userData = context.watch<UserData>();
          return WidgetDrawer(userData.email, userData.name);
        }));
  }
}

class WidgetDrawer extends StatelessWidget {
  final Notifications notification = Notifications(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
      selectNotificationSubject: selectNotificationSubject,
      platform: platform);

  final AuthService _auth = AuthService();
  final String email, name;

  WidgetDrawer(this.email, this.name);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/drawer.png'),
                    fit: BoxFit.cover)),
            accountName: Text(name),
            accountEmail: Text(email),
            // currentAccountPicture: CircleAvatar(
            //   radius: 5.0,
            //   backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            //       ? Colors.blue
            //       : Colors.white,
            //   child: Text(
            //     "A",
            //     style: TextStyle(fontSize: 40.0),
            //   ),
            // ),
          ),
          ListTile(
            title: Text("Settings",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans')),
            leading: Container(
              width: 50,
              child: FlatButton(
                child:
                    Icon(Icons.settings_outlined, size: 20, color: Colors.grey),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                color: Colors.grey[100],
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Settings()));
                },
              ),
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.grey),
          ),
          ListTile(
            title: Text("Help & Feedback",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans')),
            leading: Container(
              width: 50,
              child: FlatButton(
                child: Icon(Icons.build_outlined, size: 20, color: Colors.grey),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                color: Colors.grey[100],
                onPressed: () {},
              ),
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.grey),
          ),
          ListTile(
            title: Text("Alerts & Notifications",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans')),
            leading: Container(
              width: 50,
              child: FlatButton(
                child: Icon(Icons.notifications_outlined,
                    size: 20, color: Colors.grey),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                color: Colors.grey[100],
                onPressed: () {},
              ),
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.grey),
          ),
          ListTile(
            onTap: () async {
                // notification.initState(notification.selectNotificationSubject,
                // notification.selectedNotificationPayload);
              await _auth.signOut();
              notification.showNotification('QuickSale',
                'See you soon $name!', 'Closed');
            },
            title: Text("Logout",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans')),
            leading: Container(
              width: 50,
              child: FlatButton(
                child: Icon(Icons.logout, size: 20, color: Colors.grey),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                color: Colors.grey[100],
                onPressed: () {},
              ),
            ),
            trailing: Icon(Icons.navigate_next, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
