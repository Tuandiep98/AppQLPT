import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:house_manager2/src/app.dart';
import 'package:house_manager2/src/blocs/Login_bloc.dart';
import 'package:house_manager2/src/resource/Home_page.dart';
import 'package:house_manager2/src/resource/Register_page.dart';
import 'package:house_manager2/src/resource/dialog/loading_dialog.dart';
import 'package:house_manager2/src/resource/dialog/msg_dialog.dart';
import 'package:house_manager2/src/runHome.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();
  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
              child: Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffd8d8d8)
                ),
                child: FlutterLogo(),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: Text("Hello\nWelcome Back",style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: StreamBuilder(
                  stream: bloc.UserStream ,
                  builder: (context, snapshot) =>
                  TextField(
                    controller: _userController,
                    style: TextStyle(fontSize: 18,color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "USERNAME",
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelStyle:
                        TextStyle(color: Color(0xff888888),fontSize: 15)
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,40),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  StreamBuilder(
                    stream: bloc.PassStream,
                    builder: (context,snapshot) =>
                      TextField(
                        style: TextStyle(fontSize: 18,color: Colors.black),
                        controller: _passController,
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                            labelText: "PASSWORD",
                            errorText: snapshot.hasError ? snapshot.error : null,
                            labelStyle:
                            TextStyle(color: Color(0xff888888),fontSize: 15)
                        ),
                      )
                    ,)
                  ,
                  GestureDetector(
                      onTap: onTongleShowPass,
                      child: Text(_showPass ? "HIDE" : "SHOW",style: TextStyle(color: Colors.blue,fontSize: 13,fontWeight: FontWeight.bold),))
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.fromLTRB(0,0,0,20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: RaisedButton(onPressed: onSignInClick,
                  child: Text("SIGN IN",style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                ),
              ),
            )
            ,Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,30),
              child: Container(
                alignment: AlignmentDirectional.center,
                child: RichText(
                  text: TextSpan(
                    text: "new user?",
                    style: TextStyle(color: Color(0xff606470),fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                        ..onTap = (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=>RegisterPage()
                            )
                          );
                        },
                        text: "Sign up for new account",
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
  void onTongleShowPass(){
    setState(() {
      _showPass = !_showPass;
    });
  }
  void onSignInClick(){
    String email = _userController.text;
    String pass = _passController.text;
    LoadingDialog.showLoadingDialog(context, "Loading...");
    bloc.signIn(email, pass, (){
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> RunHome()));
    }, (msg){
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", msg);
    });
  }
  Widget goToHome (BuildContext context){
    return RunHome();
  }
}

