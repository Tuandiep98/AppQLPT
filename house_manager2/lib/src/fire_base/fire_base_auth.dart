import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email,String pass,String phone,String name,Function onSuccess,Function(String) onRegisterError){
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user){
        _createUser(user.user.uid,email,name,phone,onSuccess,onRegisterError);
        print(user);
    }).catchError((err){
      _onSignUpErr(err.code,onRegisterError);
    });
  }

  void signIn(String email,String pass,Function onSuccess,Function(String) onSignInError){
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user){
      print("On sign in success");
      onSuccess();
    }).catchError((err){
      _onSignInErr(err.code, onSignInError);
    });
  }
  _createUser(String userId,String email,String name,String phone,Function onSuccess,Function(String) onRegisterError){
    var user = {
      "displayName" : name,
      "phoneNumber" : phone,
      "email" : email,
    };
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user){
      //success
      onSuccess();
    }).catchError((err){
      //error
      onRegisterError("Sign up fail, try again");
    });
  }
  void _onSignUpErr(String code,Function(String) onRegisterError){
    switch(code){
      case "ERROR_INVALID_EMAIL":
        onRegisterError("Invalid email");
        break;
        case "ERROR_INVALID_CREDENTIAL":
          onRegisterError("Invalid email");
          break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterError("Password's not strong enough");
        break;
      default:
        onRegisterError("Sign up fail, please try again");
        break;
    }
  }
  void _onSignInErr(String code,Function(String) onSignInError){
    switch(code){
      case "ERROR_INVALID_EMAIL":
        onSignInError("Invalid email");
        break;
      case "ERROR_INVALID_CREDENTIAL":
        onSignInError("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onSignInError("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onSignInError("Password's not strong enough");
        break;
      default:
        onSignInError("Sign up fail, please try again");
        break;
    }
  }
}