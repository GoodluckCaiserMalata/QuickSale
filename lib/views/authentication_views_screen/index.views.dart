import 'package:flutter/material.dart';
import 'package:quicksale/views/authentication_views_screen/login.views.dart';
import 'package:quicksale/views/authentication_views_screen/signup.views.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/getstarted.png"),
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
                  Container(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'MartelSans'),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 300,
                      height: 50,
                      child: TextButton(
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Color(0xFF9BA9FF),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'MartelSans'),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      width: 300,
                      height: 50,
                      child: OutlinedButton(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'MartelSans'),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                          color: Colors.white,
                          width: 1.5,
                        )),
                      ))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
