import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/models/user.dart';
import 'package:flutter_app_firebase/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // I make stream provider type user cuz value return StreamProvider<User> from main yea

    final user =Provider.of<User>(context);


    // return either home or authenticate widget
    if (user == null){
      return  Authenticate();
    }else{
      return Home();
    }
  }
}
