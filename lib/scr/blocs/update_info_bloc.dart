import 'dart:async';

import 'package:flutter_app/scr/validators/validations.dart';

class UpdateInfoBloc{
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _nameController = new StreamController();
  Stream get userStream=>_userController.stream;
  Stream get passStream=>_passController.stream;
  Stream get phoneStream=> _phoneController.stream;
  Stream get nameStream=> _nameController.stream;
  bool isValidInfo(String username){
    if(!Validations.isValidUser(username)){
      _userController.sink.addError("Tài khoản không hợp lệ");
      return false;
    }
    _userController.sink.add("OK");

    return true;
  }
  void dispose(){
    _userController.close();
    _phoneController.close();
    _passController.close();
    _nameController.close();
  }
}