import 'package:quicksale/views/profile_views_sceen/favorites.views.dart';
import 'package:quicksale/views/profile_views_sceen/profile.views.dart';
import 'package:quicksale/views/shop_views_screen/discover.views.dart';
import 'package:quicksale/views/shop_views_screen/mycart.views.dart';
import 'package:quicksale/views/authentication_views_screen/index.views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/models/user.dart';


class Shop extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: MyNavigationBar (),  
    );  
  }  
}  
  
class MyNavigationBar extends StatefulWidget {  
  MyNavigationBar ({Key key}) : super(key: key);  
  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  
  
class _MyNavigationBarState extends State<MyNavigationBar > {  
  int _selectedIndex = 0;  

 List<Widget> _widgetOptions = <Widget>[
    Discover(),
    Favorites(),
    MyCart(),
    Profile(),
  ];
  
  @override  
  Widget build(BuildContext context) {  
    final user = context.watch<UserModel>();
    
    return user == null ? GetStarted() : Scaffold(  
      body:  _widgetOptions.elementAt(_selectedIndex),  
       
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFF9BA9FF),
      unselectedItemColor: Colors.black26,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.favorite_border_outlined),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.shopping_cart_outlined),
          label: 'My Cart',
        ),
        //  BottomNavigationBarItem(
        //    icon: new Icon(Icons.message_outlined),
        //    label: 'Message',
        //  ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        )
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    )
    );  
  }  
}  