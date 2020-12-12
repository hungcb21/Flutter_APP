import 'dart:async';

import 'package:flutter_app/scr/fire_base/firebase_auth_own.dart';
import 'package:flutter_app/scr/validators/validations.dart';

class UploadStoreBloc{
  StreamController _nameStoreController = new StreamController();
  StreamController _addressController = new StreamController();
  StreamController _cityController = new StreamController();
  StreamController _districtController = new StreamController();
  StreamController _timeStartController = new StreamController();
  StreamController _timeEndController = new StreamController();
  Stream get nameStoreStream=>_nameStoreController.stream;
  Stream get addressStream=>_addressController.stream;
  Stream get cityStream=>_cityController.stream;
  Stream get districtStream=>_districtController.stream;
  Stream get timeStartStream=>_timeStartController.stream;
  Stream get timeEndStream=>_timeEndController.stream;
  var _fierAuth= FierAuth();
  bool isValidInforStore(String nameStore,String address,String city,String district,String timestar,String timeEnd)
  {
    if(!Validations.isValidPassword(nameStore)){
      _nameStoreController.sink.addError("Tên cửa hàng phải trên 6 ký tự");
      return false;
    }
    _nameStoreController.sink.add("Ok");
    if(!Validations.isValidPassword(address)){
      _addressController.sink.addError("Địa chỉ phải trên 6 ký tự");
      return false;
    }
    _addressController.sink.add("Ok");
    if(!Validations.isValidcity(city)){
      _cityController.sink.addError("Tên thành phố không hợp lệ");
      return false;
    }
    _cityController.sink.add("Ok");
    if(!Validations.isValidcity(district)){
      _districtController.sink.addError("Quận không hợp lệ");
      return false;
    }
    _districtController.sink.add("Ok");
    if(!Validations.isValidcity(timestar)){
      _timeStartController.sink.addError("Thời gian phải có AM hoặc PM");
      return false;
    }
    _timeStartController.sink.add("Ok");
    if(!Validations.isValidcity(timeEnd)){
      _timeEndController.sink.addError("Thời gian phải có AM hoặc PM");
      return false;
    }
    _timeEndController.sink.add("Ok");
    return true;
  }
  void UploadStore(String image,String nameStore,String address,String city,String district,String timeStart,String timeEnd,String descripton,Function onSuccess){
    _fierAuth.upLoadStore(image,nameStore, address, city,district,timeStart,timeEnd,descripton, onSuccess);
  }
  void dispose(){
    _districtController.close();
    _cityController.close();
    _addressController.close();
    _nameStoreController.close();
    _timeStartController.close();
    _timeEndController.close();
  }
}