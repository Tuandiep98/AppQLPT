

import 'dart:async';

import 'package:house_manager2/src/fire_base/fire_base_auth.dart';
import 'package:house_manager2/src/validators/validations.dart';

class LoginBloc {
  var _FirAuth = FirAuth();
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get UserStream  => _userController.stream;
  Stream get PassStream  => _passController.stream;

  bool isValidInfo(String username, String password){
    if(!Validations.isValidUser(username)){
      _userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _userController.sink.add("OK");
    if(!Validations.isValidPass(password)){
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passController.sink.add("OK");
    return true;
  }

  void signIn(String email,String pass,Function onSuccess,Function(String) onSignInError){
    _FirAuth.signIn(email, pass, onSuccess, onSignInError);
  }

  void dispose(){
    _userController.close();
    _passController.close();
  }
}