
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/blocs/AddHouse_bloc.dart';
import 'package:house_manager2/src/blocs/Register_bloc.dart';
import 'package:house_manager2/src/fire_base/fire_base_auth.dart';
import 'package:house_manager2/src/resource/Dashboard_page.dart';
import 'package:house_manager2/src/resource/Home_page.dart';
import 'package:house_manager2/src/resource/House_items_page.dart';
import 'package:house_manager2/src/resource/House_page.dart';
import 'package:house_manager2/src/resource/Login_page.dart';
import 'package:house_manager2/src/resource/dialog/loading_dialog.dart';
import 'package:house_manager2/src/resource/dialog/msg_dialog.dart';
import 'package:house_manager2/src/runHome.dart';

class AddHousePage extends StatefulWidget{
  @override
  _AddHousePageState createState() => _AddHousePageState();
}

class _AddHousePageState extends State<AddHousePage> {
  AddHouseBloc bloc = new AddHouseBloc();
  TextEditingController _nameHouseController = new TextEditingController();
  TextEditingController _addressHouseController = new TextEditingController();
  TextEditingController _numberHouseController = new TextEditingController();
  TextEditingController _floorHouseController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar
        (
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton
          (
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Thêm nhà trọ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        // actions: <Widget>
        // [
        //   Container
        //   (
        //     margin: EdgeInsets.only(right: 8.0),
        //     child: Row
        //     (
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>
        //       [
        //         Text('beclothed.com', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14.0)),
        //         Icon(Icons.arrow_drop_down, color: Colors.black54)
        //       ],
        //     ),
        //   )
        // ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: StreamBuilder(
                  stream: bloc.NameHouseStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _nameHouseController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Tên nhà trọ",
                            errorText: snapshot.hasError ? snapshot.error : null,
                            labelStyle:
                            TextStyle(color: Color(0xff888888),fontSize: 15)
                        ),
                      )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: StreamBuilder(
                  stream: bloc.AddressHouseStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _addressHouseController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Địa chỉ",
                            errorText: snapshot.hasError ? snapshot.error : null,
                            labelStyle:
                            TextStyle(color: Color(0xff888888),fontSize: 15)
                        ),
                      )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: StreamBuilder(
                  stream: bloc.NumberHouseStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _numberHouseController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Số lượng phòng",
                            errorText: snapshot.hasError ? snapshot.error : null,
                            labelStyle:
                            TextStyle(color: Color(0xff888888),fontSize: 15),
                        ),
                      )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: StreamBuilder(
                  stream: bloc.FloorHouseStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _floorHouseController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "Số tầng",
                            errorText: snapshot.hasError ? snapshot.error : null,
                            labelStyle:
                            TextStyle(color: Color(0xff888888),fontSize: 15)
                        ),
                      )
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(0,0,0,40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(onPressed: onCreateHouseClick,
                  child: Text("THÊM",style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void onCreateHouseClick(){
    var isValid = bloc.isValidInfo(_nameHouseController.text, _addressHouseController.text,_numberHouseController.text,_floorHouseController.text);
    if(isValid){
      //loading dialog
      //LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.addHouse(_nameHouseController.text, _addressHouseController.text,_numberHouseController.text,_floorHouseController.text, (){
        //hide dialog
        LoadingDialog.hideLoadingDialog(context);
        //navigator to new page
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddHousePage()));
        MsgDialog.showMsgDialog(context, "Create House success", 'Successfully!');
      },(msg){
        //hide dialog
        //LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Create House fail", msg);
        //show message dialog
      });
    }
  }
}