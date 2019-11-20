import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/resource/Login_page.dart';
import 'package:house_manager2/src/resource/Register_page.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(home: LoginPage());
  }
}