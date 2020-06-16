import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/services/auth.dart';
import 'package:flutter_app_firebase/sheard/constants.dart';
import 'package:flutter_app_firebase/sheard/loading.dart';
class Register extends StatefulWidget {

  final Function toggleView ; // cuz we need to pass func by contructor
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: (){
              widget.toggleView();
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
                    if (this.mounted) {
                      setState(() => email = val);
                    }
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val)=> val.length < 6 ? 'Enter an Password Please > 6 charachters !' : null, // i will get back to make this function more secure
                obscureText: true,
                onChanged: (val){
                          setState(() => password =val );
                },
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Register',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  // validate our form based on current state
                 if(_fromKey.currentState.validate()){  // validate use property validator in TextFormField
                   setState(() =>loading = true);
                   dynamic result =  await _auth.registerWithEmailAndPassword(email, password);
                   if(result == null ){
                          setState(() {
                            error = 'please register with correct email ...';
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
