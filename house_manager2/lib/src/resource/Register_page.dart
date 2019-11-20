import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/blocs/Register_bloc.dart';
import 'package:house_manager2/src/resource/Home_page.dart';
import 'package:house_manager2/src/resource/Login_page.dart';
import 'package:house_manager2/src/resource/dialog/loading_dialog.dart';
import 'package:house_manager2/src/resource/dialog/msg_dialog.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
  }

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc bloc = new RegisterBloc();
  TextEditingController _fullnameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
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
                  stream: bloc.FullNameStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _fullnameController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "FULLNAME",
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
                  stream: bloc.PhoneStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _phoneController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "PHONE",
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
                  stream: bloc.EmailStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _emailController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "EMAIL",
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
                  stream: bloc.PassStream ,
                  builder: (context, snapshot) =>
                      TextField(
                        controller: _passController,
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        decoration: InputDecoration(
                            labelText: "PASSWORD",
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
                child: RaisedButton(onPressed: onSignUpClick,
                  child: Text("SIGN UP",style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,30),
              child: Container(
                alignment: AlignmentDirectional.center,
                child: RichText(
                  text: TextSpan(
                      text: "Already has account?",
                      style: TextStyle(color: Color(0xff606470),fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context)=>LoginPage()
                                    )
                                );
                              },
                            text: "Login",
                            style: TextStyle(color: Color(0xff3277D8),fontSize: 16)
                        )
                      ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void onSignUpClick(){
    var isValid = bloc.isValidInfo(_fullnameController.text, _passController.text,_emailController.text,_phoneController.text);
    if(isValid){
      //loading dialog
      LoadingDialog.showLoadingDialog(context, "Loading...");
      bloc.signUp(_emailController.text, _passController.text, _phoneController.text, _fullnameController.text, (){
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },(msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Lỗi đăng nhập!", msg);
        //show message dialog
      });
    }
  }
}