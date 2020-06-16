import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/models/brew.dart';
import 'package:flutter_app_firebase/screens/home/settings_form.dart';
import 'package:flutter_app_firebase/services/auth.dart';
import 'package:flutter_app_firebase/services/database.dart';
import 'package:provider/provider.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override

  Widget build(BuildContext context) {

    // i make this func here in build cuz i need context yea ...
    void _showSettingPanel(){
      showModalBottomSheet(context: context,
          builder: (context){
              return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child:SettingsForm(),
              ) ;
          });
    }
    return StreamProvider<List<Brew>>.value(
     value: DatabaseServices().brews, // here brews is func return stream yea
     child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title:  Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
              FlatButton.icon(
                  icon:Icon(Icons.person),
                  label: Text('logout'),
                  onPressed:() async {
                    await _auth.signOut();
                  },
              ),
          FlatButton.icon(
            icon:Icon(Icons.settings),
            label: Text('Setting'),
            onPressed:() => _showSettingPanel(),
          ),
           ],
        ),
       body: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/coffee_background.jpg'),
             fit: BoxFit.cover
           ),
         ),
         child: BrewList(),
       ),
      )
    );
  }
}
