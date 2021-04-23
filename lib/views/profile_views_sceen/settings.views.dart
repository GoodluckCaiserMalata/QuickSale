import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey),
          elevation: 1,
          centerTitle: true,
          title: Text('Settings',
              style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: ListView(
              children: [
                ListTile(
                  title: Text("Change Password",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'MartelSans')),
                  leading: Container(
                    width: 50,
                    child: FlatButton(
                      child: Icon(Icons.lock_outline,
                          size: 20, color: Colors.grey),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                  title: Text("Update Address",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'MartelSans')),
                  leading: Container(
                    width: 50,
                    child: FlatButton(
                      child: Icon(Icons.edit_location_outlined,
                          size: 20, color: Colors.grey),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                  title: Text("Push Notifications",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'MartelSans')),
                  leading: Container(
                    width: 50,
                    child: FlatButton(
                      child: Icon(Icons.notifications_on_outlined,
                          size: 20, color: Colors.grey),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      color: Colors.grey[100],
                      onPressed: () {},
                    ),
                  ),
                  trailing: SwitchScreen(),
                ),
                Divider(),
                ListTile(
                  title: Text("Privacy Policy",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'MartelSans')),
                  leading: Container(
                    width: 50,
                    child: FlatButton(
                      child: Icon(Icons.privacy_tip_outlined,
                          size: 20, color: Colors.grey),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                  title: Text("Terms & Conditions",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'MartelSans')),
                  leading: Container(
                    width: 50,
                    child: FlatButton(
                      child:
                          Icon(Icons.mode_edit, size: 20, color: Colors.grey),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            )),
);
  }
}

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1,
          child: Switch(
            onChanged: toggleSwitch,
            value: isSwitched,
            activeColor: Color(0xFF9BA9FF),
            activeTrackColor: Colors.grey[300],
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey[300],
          )),
    ]);
  }
}
