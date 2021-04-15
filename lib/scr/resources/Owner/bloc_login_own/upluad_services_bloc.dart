import 'dart:async';

import 'package:flutter_app/scr/fire_base/firebase_auth_own.dart';
import 'package:flutter_app/scr/fire_base/upload_services.dart';
import 'package:flutter_app/scr/validators/validations.dart';

class UploadSServicesBloc{
  var _upSer= UpServicesToFir();
  StreamController _nameServicesController = new StreamController();
  StreamController _priceController = new StreamController();
  StreamController _descriptionController = new StreamController();
  Stream get nameSerStream=>_nameServicesController.stream;
  Stream get priceSerStream=>_priceController.stream;
  Stream get descStream=>_descriptionController.stream;

  bool isValidInforStore(String nameSer,double price,String desc)
  {
    if(!Validations.isValidNameServices(nameSer)){
      _nameServicesController.sink.addError("Tên dịch vụ phải trên 6 ký tự");
      return false;
    }
    _nameServicesController.sink.add("Ok");
    if(!Validations.isValidPriceServices(price)){
      _priceController.sink.addError("Giá không hợp lệ");
      return false;
    }
    _priceController.sink.add("Ok");
    return true;
  }
  void UploadServices(String name,double price,String desc,String image,Function onSuccess){
    _upSer.uploadServices(name, price, desc, image, onSuccess);
  }
  void dispose(){
    _priceController.close();
    _nameServicesController.close();
    _descriptionController.close();
  }
}