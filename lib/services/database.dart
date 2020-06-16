import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_firebase/models/brew.dart';
import 'package:flutter_app_firebase/models/user.dart';


class DatabaseServices{

  final String uid ;
  DatabaseServices({this.uid});


  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars , String name , int strength) async{
    return await brewCollection.document(uid).setData({
        'sugars': sugars ,
        'name':name,
        'strength': strength,
    });
  }



  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        sugars: doc.data['sugars'] ?? '0',
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot documentSnapshot){
      return UserData( // based on document yea so that's why i make this class UserData yea
        uid: uid,
        sugars: documentSnapshot.data['sugars'],
        name: documentSnapshot.data['name'],
        strength: documentSnapshot.data['strength'],
      );

  }


  // use this data in home screen
  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // listing for document particular of id
  //get userData stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}