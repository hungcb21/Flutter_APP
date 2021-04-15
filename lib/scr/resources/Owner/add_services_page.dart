import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/scr/resources/Owner/bloc_login_own/upluad_services_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddServices extends StatefulWidget {
  @override
  _AddServicesState createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  UploadSServicesBloc bloc = new UploadSServicesBloc();
  TextEditingController NameServicesController = new TextEditingController();
  TextEditingController PriceServicesController = new TextEditingController();
  TextEditingController DescServicesController = new TextEditingController();
  Query query;
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  var uid, imageUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = _fireBaseAuth.currentUser.uid;
    query = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(uid)
        .child("Services");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  (imageUrl != null)
                      ? Image.network(
                          imageUrl,
                          height: 200,
                          width: 200,
                        )
                      : Placeholder(
                          fallbackHeight: 50,
                          fallbackWidth: 50,
                        ),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      onPressed: () => uploadImage(),
                      child: Text(
                        "Upload image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      "Thêm dịch vụ ",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    controller: NameServicesController,
                    decoration: InputDecoration(
                        labelText: "Tên dịch vụ",
                        // hintText: "Thời gian phải có AM hoặc PM VD:7.00AM",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                  TextField(
                    controller: PriceServicesController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Giá dịch vụ",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                  TextField(
                    controller: DescServicesController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Môt tả",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: SizedBox(
                      width: 140,
                      height: 40,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        onPressed: onInsert,
                        child: Text(
                          "Thêm",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: query,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation,  index) {
                      return new ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => ref.child(snapshot.key).remove(),
                        ),
                        title: new Text(snapshot.value["NameServices"]),
                        onTap: () {
                          // String ten = txtNameServices.text;
                          // ref.child(snapshot.key).update({
                          //   'ten':ten
                          // }).then((value) { txtNameServices.text="";});
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onInsert() {
    var isValid = bloc.isValidInforStore(
        NameServicesController.text,
        double.parse(PriceServicesController.text),
        DescServicesController.text);
    if (isValid) {
      bloc.UploadServices(
          NameServicesController.text,
          double.parse(PriceServicesController.text),
          DescServicesController.text,
          imageUrl, () {
        Fluttertoast.showToast(msg: "Thành công");
        NameServicesController.clear();
        PriceServicesController.clear();
        DescServicesController.clear();
        setState(() {
          imageUrl = null;
        });
      });
    }
  }

  uploadImage() async {
    String UID = _fireBaseAuth.currentUser.uid;
    final _storage = FirebaseStorage.instance;
    PickedFile image;
    final _picker = ImagePicker();
    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);
    if (image != null) {
      var snapshot = await _storage.ref().child(UID).putFile(file);
      var dowloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = dowloadUrl;
      });
    } else {
      print("Chua co anh");
    }
  }
}
