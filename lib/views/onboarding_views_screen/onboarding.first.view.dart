import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quicksale/views/authentication_views_screen/index.views.dart';

class OnboardingFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              // constraints: BoxConstraints(maxHeight: 600),
              height: MediaQuery.of(context).size.height * 0.80,
              child: Image.asset("assets/images/Onboarding1.png",
                  fit: BoxFit.cover),
            ),
            Container(
                child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    padding: EdgeInsets.only(top: 80, right: 30),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetStarted()));
                      },
                      child: Text(
                        'SKIP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'MartelSans'),
                      ),
                    ),
                  )
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      'Buy or Exchange Products',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'MartelSans'),
                    ),
                  )
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.55 , bottom: 25),
                      child: Container(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.80),
                          child: Text(
                            'Browse any second-hand items that fits your need. Find your favorite product and buy/exchange it. ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'MartelSans'),
                          ),
                        ),
                      ))
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      width: MediaQuery.of(context).size.width*0.35,
                      height: 20,
                      child: Container(
                          child: Image.asset("assets/images/dots1.png"))),
                ]),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
