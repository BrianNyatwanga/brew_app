//LISTENS TO AUTH CHANGES
import 'package:brew_app/models/user.dart';
import 'package:brew_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

//return either home or Auth
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }

  }
}
