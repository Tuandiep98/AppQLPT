import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class FirHouseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.reference();

  void createHouse(String nameHouse,String addressHouse,String numberHouse,String floorHouse,Function onSuccess,Function(String) onCreateHouseError){
    _firebaseAuth.currentUser().then((user){
      var data = {
        "nameHouse" : nameHouse,
        "addressHouse" : addressHouse,
        "numberHouse" : numberHouse,
        "floorHouse": floorHouse,
      };
      String user_id = user.uid;
      ref.child('Houses').child('$user_id').push().set(data).then((v){
        print("Create house success");
        onSuccess();
      }).catchError((err){
        onCreateHouseError("Create fail,please try again");
      });
    }).catchError((err){
      onCreateHouseError("Create fail,please try again");
    });
  }
}