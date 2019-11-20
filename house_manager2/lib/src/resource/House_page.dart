import 'package:flutter/material.dart';
import 'package:house_manager2/src/resource/Product_page.dart';

class HousePage extends StatefulWidget{
  @override
  _HousePageState createState() => _HousePageState();
}
class _HousePageState extends State<HousePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("House Page"),
      ),
      body: new Center(
        child: new OutlineButton(
          onPressed: goProduct,
          child: Text("Go Product"),
        ),
      ),
    );
  }
  void goProduct(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage()));
  }
}