
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/scr/resources/Owner/bloc_login_own/upload_store_bloc.dart';
import 'package:flutter_app/scr/resources/Owner/home_page_own.dart';
import 'package:flutter_app/scr/resources/Owner/set_time_page.dart';
import 'package:flutter_app/scr/resources/dialog/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
class UploadStore extends StatefulWidget {
  @override
  _UploadStoreState createState() => _UploadStoreState();
}

class _UploadStoreState extends State<UploadStore> {
  UploadStoreBloc bloc = new UploadStoreBloc();
  TextEditingController _nameStoreController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();
  TextEditingController _districtController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _timeStartController = new TextEditingController();
  TextEditingController _timeEndController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  String imageUrl;
  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.yellow,
            elevation: 0,
            leading:   InkWell(
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageOwn()));},
              child: Container(
                child: Image.asset("images/left-arrow2.png"),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Container(
                  child: Image.asset("images/magnifying-glass 1.png"),
                ),
              ),
            ],
            bottom: AppBar(
              backgroundColor: Colors.yellow,
              title: Text("Upload Store",style: TextStyle(fontSize: 30,color: Colors.black),),
            ),
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xFF383443),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (imageUrl != null)
                  ?Image.network(imageUrl)
                      :Placeholder(fallbackHeight: 200,fallbackWidth: 200,)
                  ,
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                      onPressed: ()=>uploadImage(),
                      child: Text("Upload image",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle_sharp),
                      Container(
                        width: 212,
                        child: StreamBuilder(
                         stream: bloc.nameStoreStream,
                          builder: (context,snapshot)=>TextField(
                            style: TextStyle(fontSize: 18,color: Colors.white),
                            controller: _nameStoreController,
                            decoration: InputDecoration(labelText: "The name of your store",
                                errorText: snapshot.hasError ? snapshot.error:null,
                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                          ),
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_rounded),
                      Container(
                        width: 212,
                        child: StreamBuilder(
                          stream: bloc.addressStream,
                          builder: (context,snapshot)=>TextField(
                            style: TextStyle(fontSize: 18,color: Colors.white),
                            controller: _addressController,
                            decoration: InputDecoration(labelText: "Address",
                                errorText: snapshot.hasError ? snapshot.error:null,
                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                          ),
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_city),
                      Container(
                        width: 212,
                        child: StreamBuilder(
                          stream: bloc.cityStream,
                          builder: (context,snapshot)=>TextField(
                            style: TextStyle(fontSize: 18,color: Colors.white),
                            controller: _cityController,
                            decoration: InputDecoration(labelText: "City",
                                errorText: snapshot.hasError ? snapshot.error:null,
                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                          ),
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_city),
                      Container(
                        width: 212,
                        child: StreamBuilder(
                          stream: bloc.districtStream,
                          builder: (context,snapshot)=>TextField(
                            style: TextStyle(fontSize: 18,color: Colors.white),
                            controller: _districtController,
                            decoration: InputDecoration(labelText: "District",
                                errorText: snapshot.hasError ? snapshot.error:null,
                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                          ),
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer),
                      Container(
                        width: 212,
                        child: StreamBuilder(
                          stream: bloc.timeStartStream,
                          builder: (context,snapshot)=>TextField(
                            controller: _timeStartController,
                            style: TextStyle(fontSize: 18,color: Colors.white),
                            decoration: InputDecoration(labelText: "Time start",
                                labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                          ),
                        )
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer),
                      Container(
                          width: 212,
                          child: StreamBuilder(
                            stream: bloc.timeEndStream,
                            builder: (context,snapshot)=>TextField(
                              controller: _timeEndController,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(fontSize: 18,color: Colors.white),
                              decoration: InputDecoration(labelText: "Time end",
                                  labelStyle:TextStyle( color: Colors.white,fontSize:18)),
                            ),
                          )
                      )
                    ],
                  ),
                  Container(
                    height: 152,
                    width: 295,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Text("Description",style: TextStyle(fontSize: 16)),
                        Expanded(
                            child: TextField(
                              controller: _descriptionController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,//Normal textInputField will be displayed
                              maxLines: 5,
                              // expands: true,
                            )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: RaisedButton(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                            onPressed: _onUploadClicked,
                            child: Text("Verification",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: RaisedButton(
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SetTime()));},
                            child: Text("Seting time",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
  //up load của hang
  _onUploadClicked(){
    var isValid =bloc.isValidInforStore(_nameStoreController.text, _addressController.text, _cityController.text,_districtController.text,_timeStartController.text,_timeEndController.text);
    if(isValid)
      {
        // LoadingDialog.showLoadingDialog(context, "Loading...");
        bloc.UploadStore(imageUrl,_nameStoreController.text, _addressController.text, _cityController.text, _districtController.text,_timeStartController.text,_timeEndController.text,_descriptionController.text,(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageOwn()));
          // LoadingDialog.hideLoadingDialog(context);
        });
      }
  }
  //ham upload hinh anh
  uploadImage() async{
    String UID = _fireBaseAuth.currentUser.uid;
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    final _picker =ImagePicker();
    image= await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    if(image != null)
    {
      var snapshot =await _storage.ref().child(UID).putFile(file);
      var dowloadUrl = await snapshot.ref.getDownloadURL();
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

