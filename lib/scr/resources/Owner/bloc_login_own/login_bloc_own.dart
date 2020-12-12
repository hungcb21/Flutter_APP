import 'dart:async';
import 'package:flutter_app/scr/fire_base/firebase_auth_own.dart';
import 'package:flutter_app/scr/validators/validations.dart';

class LoginOwnBloc{
  var _fierAuth= FierAuth();
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();
  Stream get userStream=>_userController.stream;
  Stream get passStream=>_passController.stream;

  bool isValidInfo(String username,String pass){
    if(!Validations.isValidUser(username)){
      _userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _userController.sink.add("OK");
    if(!Validations.isValidPassword(pass)){
      _passController.sink.addError("Mật khẩu phải trên 6 ký tự");
      return false;
    }
    _passController.sink.add("Ok");
    return true;
  }
  void signIn(String email,String pass,Function onSuccess,Function(String) onSignInEror){
    _fierAuth.signIn(email, pass, onSuccess,onSignInEror);
  }
  void dispose(){
    _userController.close();
    _passController.close();
  }
}