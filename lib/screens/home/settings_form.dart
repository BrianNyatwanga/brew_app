import 'package:brew_app/helpers/loading.dart';
import 'package:brew_app/helpers/style.dart';
import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

//form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){

          UserData userData=snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your settings',
                    style: TextStyle(fontSize: 14.0)),
                SizedBox(height: 10.0),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(()=> _currentName = val),
                ),
                SizedBox(height: 20.0),
//SUGAR DROPDOWN
                DropdownButtonFormField(
                  value: _currentSugars ?? userData.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugars) {
                    return DropdownMenuItem(
                      value: sugars,
                      child: Text('$sugars sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val ),
                ),

//SLIDER
                Slider(
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  onChanged: (val) => setState(()=> _currentStrength = val.round()),

                ),

                RaisedButton(
                    color: Colors.pink,
                    child: Text('Update', style: TextStyle(color: white),),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    })
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
