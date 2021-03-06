import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/scr/resources/Class/UserClass.dart';

import '../Customer/login_page.dart';
class Status2 extends StatefulWidget {
  final int index;
  String uid;
  Status2(this.index,this.uid);
  @override
  _Status2State createState() => _Status2State();
}

class _Status2State extends State<Status2> {
  final String serverToken = '	AAAAE20gnpk:APA91bFWWMS8ocapsunPLjwB4i7xAfJ-VTW9Nq0YROTIudvwnGofqc5K8LWmRoy0YKQEaCTri3Ezrr65duFXx4feUKnqylt6X6M1892mAXcFeMZFYlCcUqV1kvsXolg6vobI_6HiJdVB';
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  List<UserProfile> datalist = [];
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String time,name,date,phone,email,address,nameStore,tokenCus,imageCus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var uid = firebaseUser.currentUser.uid;
    DatabaseReference user= FirebaseDatabase.instance.reference().child("Stores");
    user.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        setState(() {
          nameStore=values["NameStore"];
        });

      });
    });
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Stores").child(uid).child("Waiting");
      reference.orderByKey().equalTo(widget.uid).once().then((
          DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          var keys= snapshot.value.keys;
          var uida= widget.uid;
          for(uida in keys)
            {
              
            }
          setState(() {
            time= values["Time"];
            date = values["Day"];
            name = values["NameCustomer"];
            phone= values["PhoneCustomer"];
            email = values["EmailCustomer"];
            address = values["Address"];
            tokenCus = values["tokenCus"];
            imageCus=values["ImageCus"];
          });
        });
      });


  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          elevation: 0,
          leading:   InkWell(
            onTap: () {Navigator.pop(context);},
            child: Container(
              child: Image.asset("images/left-arrow2.png"),
            ),
          ),
          bottom:PreferredSize(
              child: Container(
                color: Colors.yellow,
                child: Text("Status",style: TextStyle(fontSize: 30),),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight)),
        
        ),
        body: Container(
            color: Color(0xFF383443),
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: Container(
                          height: 300,
                          width: 400,
                          decoration: BoxDecoration(shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text("Time",style: TextStyle(fontSize: 15),),
                                      Text(time,style: TextStyle(fontSize: 15,color: Colors.orange),),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Date",style: TextStyle(fontSize: 15),),
                                      Text(date,style: TextStyle(fontSize: 15,color: Colors.orange),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Image.asset("images/Line 53.png"),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(imageCus),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(name??"",style: TextStyle(fontSize: 15),),
                                        Text("(+84)"+phone??"",style: TextStyle(fontSize: 15),),
                                        Text(email??"",style: TextStyle(fontSize: 15),),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                            Image.asset("images/Line 53.png"),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                    child: Icon(Icons.location_on_rounded,size: 30,color: Colors.orange,)
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(address??"",style: TextStyle(fontSize: 15),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                      ),
                    ),
                    Container(
                      height: 105,
                      width: 400,
                      decoration: BoxDecoration(shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,),
                      child: Column(
                        children: [
                          Text("Note for customer",style: TextStyle(fontSize: 16)),
                          Expanded(
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                decoration: InputDecoration(labelText: "If you have any special needs, please note here..."),
                              )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400,
                            height: 50,
                            child: RaisedButton(
                              color: Colors.deepOrange,
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                              onPressed:(){
                                _onAcceptClick();
                                Navigator.pop(context);
                              },
                              child: Text("Done",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          //   child: SizedBox(
                          //     width: 400,
                          //     height: 50,
                          //     child: RaisedButton(
                          //       color: Colors.black,
                          //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                          //       onPressed:(){
                          //         AlertDialog alert = AlertDialog(
                          //           title: Text("Từ chối"),
                          //           content: Text("Bạn có muốn từ chối tiếp nhận đặt chỗ?"),
                          //           actions: <Widget>[
                          //             FlatButton(
                          //                 child: Text("Thoát"),
                          //                 onPressed: (){Navigator.of(context, rootNavigator: true).pop();}
                          //             ),
                          //             FlatButton(
                          //               child: Text("Tiếp tục"),
                          //               onPressed:  () {
                          //                 String userUID = _firebaseAuth.currentUser.uid;
                          //                 ref.child("Stores").child(userUID).child("Waiting").child(widget.uid).remove();
                          //                 ref.child("Users").child(widget.uid).child("Waiting").child(userUID).remove();
                          //                 Navigator.of(context, rootNavigator: true).pop();
                          //                Navigator.pop(context);},
                          //             ),
                          //           ],
                          //         );
                          //         showDialog(
                          //           context: context,
                          //           builder: (BuildContext context) {
                          //             return alert;
                          //           },
                          //         );
                          //
                          //       },
                          //       child: Text("Refuse",style: TextStyle(color: Colors.white),),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

        ),
      ),
    );
  }
  _onAcceptClick(){
    String userUID = _firebaseAuth.currentUser.uid;
    Map<String,String> success ={
      'NameCustomer':name,
      'EmailCustomer':email,
      'PhoneCustomer':phone,
      'Day':date,
      'Address':address,
      'ImageCus':imageCus,
      'Time':time,
      "uid":widget.uid
    };
    Map<String,String> waitingCustomer ={
      'Time':time,
      'Date':date,
      'NameStore':nameStore,
      'Address':address,
    };
    ref.child("Stores").child(userUID).child("Success").push().set(success);
    sendAndRetrieveMessage();
    ref.child("Users").child(widget.uid).child("Success").push().set(waitingCustomer);
    ref.child("Stores").child(userUID).child("Waiting").child(widget.uid).remove();
    ref.child("Users").child(widget.uid).child("Waiting").child(userUID).remove();

  }
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Thời gian: ${time}, ngày: ${date}',
            'title': 'Bạn đã đặt chỗ thành công từ ${nameStore}'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await tokenCus,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
