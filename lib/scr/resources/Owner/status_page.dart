import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/UserClass.dart';
import 'package:flutter_app/scr/resources/Owner/home_page_own.dart';
import 'package:flutter_app/scr/resources/Owner/status_page2.dart';

import '../Customer/login_page.dart';
class Status extends StatelessWidget {
  List<UserProfile> datalist = [];
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  Query query;
  @override
  Widget build(BuildContext context) {
    var uid = firebaseUser.currentUser.uid;
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Stores").child(uid).child("Waiting");
    query=  FirebaseDatabase.instance.reference().child("Stores").child(uid).child("Waiting");
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      reference.once().then((DataSnapshot dataSnapshot) {
        datalist.clear();
        var keys = dataSnapshot.value.keys;
        var values = dataSnapshot.value;
        // reference.orderByKey().equalTo(uid).once().then((
        //     DataSnapshot snapshot) {
        //   Map<dynamic, dynamic> values = snapshot.value;
        //   values.forEach((key, values) {
        //     print(values["pass"]);
        //   });
        // });
        for (var key in keys) {
          UserProfile data = new UserProfile(
            values [key]["name"],
            values [key]["email"],
            values [key]["phone"],

          );
          datalist.add(data);
        }
      });
      return MaterialApp(
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
              child: FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: query,itemBuilder:(BuildContext context,
              DataSnapshot snapshot,Animation<double> animation,int index)
                  {
                    return InkWell(
                      onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>Status2(index,snapshot.key)));},
                      child: Card(
                          elevation: 10,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.account_circle_sharp),
                                        Column(
                                          children: [
                                            Text(snapshot.value["NameCustomer"],style: TextStyle(fontSize: 15),),
                                            Text("(+84)"+snapshot.value["PhoneCustomer"],style: TextStyle(fontSize: 15),),
                                          ],
                                        ),

                                      ],

                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                      child: Text(snapshot.value["Day"]+" "+snapshot.value["Time"],style: TextStyle(fontSize: 15)),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.add_location),
                                        Text(snapshot.value["Address"], style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Icon(Icons.arrow_forward_ios_outlined),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ),
                    );
                  }
              )

          ),
        ),
      );
    }
  }
  Widget CardUI(String name, String phone) {
    return InkWell(
      onTap: () {},
      child: Card(
          elevation: 10,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_circle_sharp),
                        Column(
                          children: [
                            Text(name, style: TextStyle(fontSize: 15),),
                            Text(phone, style: TextStyle(fontSize: 15),),
                          ],
                        ),

                      ],

                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(180, 0, 0, 0),
                      child: Text("Today 9.00", style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.add_location),
                        Text(name, style: TextStyle(fontSize: 15)),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 0, 0, 0),
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
