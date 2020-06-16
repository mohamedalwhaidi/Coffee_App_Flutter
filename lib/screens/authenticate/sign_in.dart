import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/models/user.dart';
import 'package:flutter_app_firebase/services/auth.dart';
import 'package:flutter_app_firebase/sheard/constants.dart';
import 'package:flutter_app_firebase/sheard/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView ; // cuz we need to pass func by contructor
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _fromKey =GlobalKey<FormState>(); // to identify our form
  bool loading = false ;
  // text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Rigester'),
               onPressed: (){
                widget.toggleView(); // i didn't use this.toggleView cuz this for state
                                      // object so i used widget.toggleView() refers to widget itself
               },
          )
        ],

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _fromKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val)=> val.isEmpty? 'Enter an Email Please!' : null,
                onChanged: (val){
                  setState(() => email =val );
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=> val.length < 6 ? 'Enter an Password Please > 6 charachters !' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password =val );
                },
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Sign in',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_fromKey.currentState.validate()){  // validate use property validator in TextFormField
                   setState(()=> loading = true);
                     dynamic result =  await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'could not sign in with credentials ...';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0,),
              Text(error, style: TextStyle(fontSize: 14.0,color: Colors.red),),
            ],
          ),
        ),
      ),
    );
  }
}