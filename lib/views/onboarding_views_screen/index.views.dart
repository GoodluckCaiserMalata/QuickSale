import 'package:flutter/material.dart';
import 'package:quicksale/views/onboarding_views_screen/onboarding.first.view.dart';
import 'package:quicksale/views/onboarding_views_screen/onboarding.second.view.dart';
import 'package:quicksale/views/onboarding_views_screen/onboarding.third.view.dart';
import 'package:quicksale/views/onboarding_views_screen/onboarding.fourth.view.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
      _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onChangedFunction,
        children: <Widget>[
          // Container(child: Text("First Screen")),
          // Container(child: Text("Second Screen")),
          // Container(child: Text("Third Screen")),
          // Container(child: Text("Third Screen"))
          OnboardingFirst(),
          OnboardingSecond(),
          OnboardingThird(),
          OnboardingFourth()
        ],
      ),
    );
  }
}
