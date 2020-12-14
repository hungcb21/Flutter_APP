import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class UpdateInfor extends StatefulWidget {
  @override
  _UpdateInforState createState() => _UpdateInforState();
}

class _UpdateInforState extends State<UpdateInfor> {
  String name,email,pass,address,phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase firebaseDatabase;
    FirebaseAuth firebaseAuth;
    var uid = firebaseAuth.currentUser.uid;
    DatabaseReference databaseReference= firebaseDatabase.reference().child("Users");
    databaseReference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values= snapshot.value;
      values.forEach((key, value) {
        setState(() {
          email= firebaseAuth.currentUser.email;
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
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Container(
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
                            Text(email??"Chua co"),
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
                                Text("Name"),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.lock,size: 30,),
                                Text("Password"),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone,size: 30,),
                                Text("phone"),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded,size: 30,),
                                Text("Address"),
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
            ),
          ),
        ),
      ),
    );
  }
}
