import 'package:brew_app/helpers/loading.dart';
import 'package:brew_app/helpers/style.dart';
import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //States
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: primary[100],
        appBar: AppBar(
          backgroundColor: primary[400],
          elevation: 0.1,
          title: Text("Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: (){
                  widget.toggleView();
                },
                label: Text('sign in', style: TextStyle(color: black)),
                icon: Icon(Icons.person, color: black,))
          ],
    ),
      body:Container(
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0,),
        child : Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                },),
              SizedBox(height: 10.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ long' : null,
                onChanged: (val){
                  setState(() => password = val);
                },),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(()=> loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState((){
                        loading = false;
                        error = 'please supply a valid email';
                      });
                    }
                  }
                },
                color: primary,
                child: Text('Register', style: TextStyle(color: black),),
              ),
            SizedBox(height: 12.0,),
              Text(error, style: TextStyle(color: black, fontSize: 14.0)),
            ],
          )
        ),
      ),
    );
  }
}
