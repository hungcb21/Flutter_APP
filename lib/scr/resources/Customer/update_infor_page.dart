import 'dart:core';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/scr/blocs/login_bloc.dart';
import 'package:flutter_app/scr/blocs/update_info_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
class UpdateInfor extends StatefulWidget {
  @override
  _UpdateInforState createState() => _UpdateInforState();
}

class _UpdateInforState extends State<UpdateInfor> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  UpdateInfoBloc bloc = new UpdateInfoBloc();
  bool isObscure = true;
  bool _validate = true;
  String name,email,pass,address,phone,image;
  String imageUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User user = firebaseAuth.currentUser;
    var uid = user.uid;
    DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
    databaseReference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values= snapshot.value;
      values.forEach((key, values) {
        setState(() {
          email= firebaseAuth.currentUser.email;
          name = values["name"];
          phone = values["phone"];
          pass = values["pass"];
          image = values["Image"];
        });
      });}
    );}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFF383443),
          title: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back),
          ),
          bottom: AppBar(
            backgroundColor:  Color(0xFF383443),
            title: Text("Update info",style: TextStyle(fontSize: 30),),
          ),
        ),
        body: Container(
          color:Color(0xFF383443),
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                    child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(image??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNK9yHOd59mG5Mq8YGD5l9xV-2MTXi2da9LA&usqp=CAU") ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Center(
                      child: SizedBox(
                        width: 140,
                        height: 40,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                          onPressed: ()=>uploadImage(),
                          child: Text("Upload image",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                    ),
                      child: Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 40, 0, 0),
                            child: Row(
                              children: [
                                Icon(Icons.mail_outline,size: 30,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(email??"Chua co"),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 3,
                              endIndent: 30,
                              indent: 30,
                              color: Colors.black
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person,size: 30,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(name??""),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    _updateName();
                                  },
                                    child: Icon(Icons.update_outlined,size: 30,)),
                              ],
                            ),
                          ),
                          Divider(thickness: 3,
                              endIndent: 30,
                              indent: 30,
                              color: Colors.black
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.lock,size: 30,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                          "***********"
                                    ),
                                    ),
                                  ],
                                ),
                                 InkWell(
                                   onTap: (){
                                     _showDialog();
                                   },
                                     child: Icon(Icons.update_outlined,size: 30,)),
                              ],
                            ),
                          ),
                          Divider(thickness: 3,
                              endIndent: 30,
                              indent: 30,
                              color: Colors.black
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.phone,size: 30,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(phone??""),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: (){
                                    _updatePhone();
                                  },
                                    child: Icon(Icons.update_outlined,size: 30,)),
                              ],
                            ),
                          ),
                          Divider(thickness: 3,
                              endIndent: 30,
                              indent: 30,
                              color: Colors.black
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on_rounded,size: 30,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(address??"Address"),
                                    ),
                                  ],
                                ),
                                Icon(Icons.update_outlined,size: 30,),
                              ],
                            ),
                          ),
                          Divider(thickness: 3,
                              endIndent: 30,
                              indent: 30,
                              color: Colors.black
                          ),
                        ],
                      ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextField(
                  controller: _userController,
                  decoration: new InputDecoration(
                      errorText: _validate ? "Không hợp lệ" : null,
                      labelText: "Chỉnh sửa thông tin"),
                ),
              )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Thoát'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                if(_userController.text.length<6)
                {
                  _validate =true;
                }
                else{
                  _validate=false;
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  User user = firebaseAuth.currentUser;
                  var uid = user.uid;
                  DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
                  databaseReference.child(uid).update({
                    'pass': _userController.text
                  });
                  user.updatePassword(_userController.text).then(
                          (_){Navigator.of(context, rootNavigator: true).pop();}
                  );
                }
              })
        ],
      ),
    );
  }
  _updateName() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextField(
                controller: _nameController,
                decoration: new InputDecoration(
                    errorText: _validate ? "Không hợp lệ" : null,
                    labelText: "Chỉnh sửa thông tin"),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Thoát'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('Xác nhận'),
              onPressed: () {

                if(_nameController.text.length<6)
                {
                  _validate =true;
                }
                else{
                  _validate=false;
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  User user = firebaseAuth.currentUser;
                  var uid = user.uid;
                  DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
                  databaseReference.child(uid).update({
                    'name': _nameController.text
                  }).then((_){
                    Navigator.of(context, rootNavigator: true).pop();
                    setState(() {
                      name = _nameController.text;
                      _nameController.text="";
                    });
                  });
                }
              })
        ],
      ),
    );
  }
  _updatePhone() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: new InputDecoration(
                    errorText: _validate ? "Không hợp lệ" : null,
                    labelText: "Chỉnh sửa thông tin"),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Thoát'),
              onPressed: () {
                _phoneController.text="";
                Navigator.of(context, rootNavigator: true).pop();
              }),
          new FlatButton(
              child: const Text('Xác nhận'),
              onPressed: () {

                if(_phoneController.text.length<6)
                {
                  _validate =true;
                }
                else{
                  _validate=false;
                  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                  User user = firebaseAuth.currentUser;
                  var uid = user.uid;
                  DatabaseReference databaseReference= FirebaseDatabase.instance.reference().child("Users");
                  databaseReference.child(uid).update({
                    'phone': _phoneController.text
                  }).then((_){
                    Navigator.of(context, rootNavigator: true).pop();
                    setState(() {
                      phone = _phoneController.text;
                      _phoneController.text="";
                    });
                  });
                }
              })
        ],
      ),
    );
  }
  uploadImage() async{
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    final _picker =ImagePicker();
    image= await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    if(image != null)
    {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var uid = firebaseAuth.currentUser.uid;
      var snapshot =await _storage.ref().child(uid).putFile(file);
      var ref = FirebaseDatabase.instance.reference().child("Users");
      var dowloadUrl = await snapshot.ref.getDownloadURL();
      var category ={"Image":dowloadUrl};
      ref.child(uid).update(category);
      setState(() {
        imageUrl= dowloadUrl;
      });
    }
    else
    {
      print("Chua co anh");
    }
  }
}
