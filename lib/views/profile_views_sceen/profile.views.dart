import 'package:flutter/material.dart';
import 'package:quicksale/views/profile_views_sceen/drawer.views.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/views/profile_views_sceen/favorites.views.dart';
import 'package:quicksale/views/profile_views_sceen/history.views.dart';
import 'package:quicksale/views/profile_views_sceen/manage.views.dart';
import 'package:quicksale/views/profile_views_sceen/personalinfo.views.dart';
import 'package:quicksale/views/profile_views_sceen/settings.views.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return MultiProvider(
        providers: [
          Provider<DatabaseService>(
            create: (_) => DatabaseService(documentId: user.uid),
          ),
          StreamProvider(
            initialData: UserData('', '', '', '', '', '', '', ''),
            create: (context) => context.read<DatabaseService>().userData,
          ),
        ],
        child: Builder(
          builder: (context) {
            final userData = context.watch<UserData>();
            return WidgetProfile(
                userData.email, userData.name, userData.photoURL);
          },
        ));
  }
}

class WidgetProfile extends StatelessWidget {
  final String email, name, photoURL;

  WidgetProfile(this.email, this.name, this.photoURL);
  @override
  Widget build(BuildContext context) {
    // final user = context.watch<UserModel>();

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 1,
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(child: Container(
        margin: EdgeInsets.only(top: 20, right: 40, left: 40),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image(
                    image: NetworkImage(photoURL),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(name,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'MartelSans')),
                      ),
                      SizedBox(
                        child: Text(email,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'MartelSans')),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.person_outlined,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonalInfo()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Personal Information'),
                    ),
                    const Icon(Icons.navigate_next,
                        size: 25.0, color: Colors.grey),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.bookmark_outline,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => History()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Order History'),
                    ),
                    const Icon(Icons.navigate_next,
                        size: 25.0, color: Colors.grey),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.shopping_cart_outlined,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ManageSale()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Manage Sale'),
                    ),
                    const Icon(Icons.navigate_next,
                        size: 25.0, color: Colors.grey),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.favorite_border_outlined,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Favorites()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Favorites'),
                    ),
                    Icon(Icons.navigate_next, size: 25.0, color: Colors.grey),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.settings_outlined,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Settings'),
                    ),
                    Icon(Icons.navigate_next, size: 25.0, color: Colors.grey),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.build_outlined,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Help & Feedback'),
                    ),
                    Icon(Icons.navigate_next, size: 25.0, color: Colors.grey),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Container(
                        child: FlatButton(
                          child: Icon(Icons.notifications_outlined,
                              size: 25, color: Colors.grey),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                          ),
                          color: Colors.grey[100],
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Alerts & Notifications'),
                    ),
                    Icon(Icons.navigate_next, size: 25.0, color: Colors.grey),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    )));
  }
}
