import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/UserClass.dart';
import 'package:flutter_app/scr/resources/Owner/home_page_own.dart';

import '../Customer/login_page.dart';
class Status2 extends StatefulWidget {
  final int index;
  String uid;
  Status2(this.index,this.uid);
  @override
  _Status2State createState() => _Status2State();
}

class _Status2State extends State<Status2> {
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  List<UserProfile> datalist = [];
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.reference();


  String time,name,date,phone,email,address,nameStore;
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
          setState(() {
            time= values["Time"];
            date = values["Day"];
            name = values["NameCustomer"];
            phone= values["PhoneCustomer"];
            email = values["EmailCustomer"];
            address = values["Address"];
          });
        });
      });


  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ],
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
                              child: Text("Accept",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: SizedBox(
                              width: 400,
                              height: 50,
                              child: RaisedButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                                onPressed:(){
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Từ chối"),
                                    content: Text("Bạn có muốn từ chối tiếp nhận đặt chỗ?"),
                                    actions: <Widget>[
                                      FlatButton(
                                          child: Text("Thoát"),
                                          onPressed: (){Navigator.of(context, rootNavigator: true).pop();}
                                      ),
                                      FlatButton(
                                        child: Text("Tiếp tục"),
                                        onPressed:  () {
                                          String userUID = _firebaseAuth.currentUser.uid;
                                          ref.child("Stores").child(userUID).child("Waiting").child(widget.uid).remove();
                                          ref.child("Users").child(widget.uid).child("Waiting").child(userUID).remove();
                                          Navigator.of(context, rootNavigator: true).pop();
                                         Navigator.pop(context);},
                                      ),
                                    ],
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );

                                },
                                child: Text("Refuse",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
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
      'Time':time
    };
    Map<String,String> waitingCustomer ={
      'Time':time,
      'Date':date,
      'NameStore':nameStore,
      'Address':address,
    };
    ref.child("Stores").child(userUID).child("Success").push().set(success);
    ref.child("Users").child(widget.uid).child("Success").push().set(waitingCustomer);
    ref.child("Stores").child(userUID).child("Waiting").child(widget.uid).remove();
    ref.child("Users").child(widget.uid).child("Waiting").child(userUID).remove();
  }

}
