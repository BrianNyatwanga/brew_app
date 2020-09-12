import 'package:brew_app/helpers/style.dart';
import 'package:brew_app/models/brew.dart';
import 'package:brew_app/screens/home/settings_form.dart';
import 'package:brew_app/services/auth.dart';
import 'package:brew_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context)=> Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
        child: SettingsForm(),
      ));
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: primary[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: primary[400],
          elevation: 0.1,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  print('signed out');},
                icon: Icon(Icons.person),
                label: Text("logout")),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text(''),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
            ),
          ),
            child: BrewList()),
      ),
    );
  }
}
