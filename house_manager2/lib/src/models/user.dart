import 'package:firebase_database/firebase_database.dart';

class User {
  static const NAME = "name";
  static const PHONE = "phone";
  static const EMAIL = "email";

  String name;
  String phone;
  String email;

  User(this.name, this.phone, this.email);

  //  String get key  => _key;
//  String get date  => _date;
//  String get title  => _title;
//  String get body  => _body;


  User.fromSnapshot(DataSnapshot snap):
        this.name = snap.value[NAME],
        this.phone = snap.value[PHONE],
        this.email = snap.value[EMAIL];

  Map toMap(){
    return {NAME: name, PHONE: phone, EMAIL: email};
  }
  void update(String displayName, String phoneNumber, String email) {
    this.name = displayName;
    this.phone = phoneNumber;
    this.email = email;
  }

}