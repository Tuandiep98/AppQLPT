import 'dart:async';
import 'package:house_manager2/src/validators/validations.dart';
import 'package:house_manager2/src/fire_base/fire_base_auth.dart';

class RegisterBloc {
  var _FirAuth = FirAuth();

  StreamController _fullnameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get FullNameStream  => _fullnameController.stream;
  Stream get PassStream  => _passwordController.stream;
  Stream get PhoneStream  => _phoneController.stream;
  Stream get EmailStream  => _emailController.stream;

  bool isValidInfo(String fullname, String password,String email,String phone){
    if(!Validations.isValidFullname(fullname)){
      _fullnameController.sink.addError("Tên không được để trống");
      return false;
    }
    _fullnameController.sink.add("OK");
    if(!Validations.isValidPass(password)){
      _passwordController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passwordController.sink.add("OK");
    if(!Validations.isValidEmail(email)){
      _emailController.sink.addError("Email không hợp lệ");
      return false;
    }
    _emailController.sink.add("OK");
    if(!Validations.isValidPhone(phone)){
      _phoneController.sink.addError("số điện thoại trống");
      return false;
    }
    _phoneController.sink.add("OK");
    return true;
  }
  void signUp(String email,String pass,String phone, String name,Function onSuccess,Function(String) onRegisterError){
    _FirAuth.signUp(email, pass, phone, name, onSuccess,onRegisterError);
  }

  void dispose(){
    _fullnameController.close();
    _passwordController.close();
    _phoneController.close();
    _emailController.close();
  }
}