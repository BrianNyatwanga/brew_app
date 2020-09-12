import 'package:brew_app/helpers/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(
        child: SpinKitChasingDots(
          color: primary,
          size: 50.0,
        ),
      ),
    );
  }
}
