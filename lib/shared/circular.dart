import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: SpinKitFadingCircle(
                color: Color(0xFF9BA9FF),
                size: 50.0,
              ),
            ),
          ],
        ));
  }
}
