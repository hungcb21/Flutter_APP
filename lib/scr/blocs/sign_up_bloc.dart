import 'dart:async';
import 'package:flutter_app/scr/fire_base/fire_base-auth.dart';
import 'package:flutter_app/scr/validators/validations.dart';
class SignUpBloc{
  var _firAuth= FirAuth();
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _nameController = new StreamController();
  Stream get userStream=>_userController.stream;
  Stream get passStream=>_passController.stream;
  Stream get phoneStream=> _phoneController.stream;
  Stream get nameStream=> _nameController.stream;

  bool isValidInfo(String username,String pass,String phone,String name){
    if(!Validations.isValidUser(username)){
      _userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _userController.sink.add("OK");
    if(!Validations.isValidName(name)){
      _nameController.sink.addError("Tên không hợp lệ");
      return false;
    }
    _nameController.sink.add("OK");
    if(!Validations.isValidPassword(phone))
      {
        _phoneController.sink.addError("SDT không hợp lệ");
        return false;
      }
    _phoneController.sink.add("Ok");
    if(!Validations.isValidPassword(pass)){
      _userController.sink.addError("Mật khẩu phải trên 6 ký tự");
      return false;
    }
    _passController.sink.add("Ok");
    return true;
  }
  void signUp(String email,String pass,String phone,String name,Function onSuccess,Function(String) onSignInEror){
    _firAuth.signUp(email, pass, phone,name, onSuccess,onSignInEror);
  }
  void dispose(){
    _userController.close();
    _phoneController.close();
    _passController.close();
    _nameController.close();
  }
}