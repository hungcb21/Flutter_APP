import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/scr/fire_base/fire_base-auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/UserClass.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String ten2;
  List<UserProfile> datalist=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Users");
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // firebaseUser = firebaseAuth.currentUser;
    final User user = firebaseAuth.currentUser;
    // var uid=getCurrentUID();
    final uid = user.uid;
    reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print(values["pass"]);
        setState(() {
          _todoName=values["name"];
        });

      });
    });
    reference.once().then((DataSnapshot dataSnapshot){
      datalist.clear();
      var keys= dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      var userid = getCurrentUID();
      var query = reference.orderByChild("uid").equalTo(user.uid);
      var team;
      reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
        Map<dynamic,dynamic> values = snapshot.value;
        values.forEach((key,values) {
          print(values["pass"]);
          team = values["pass"];
        });
      });

      // for(var key in keys)
      //
      // {
        UserProfile data=new UserProfile(
          values [uid]["name"],
          values [uid]["email"],
          values [uid]["phone"],

        );
        datalist.add(data);
      // }
    });

  }

  @override
  String _todoName = "Display the todo name here";
  FirebaseAuth firebaseAuth;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          constraints:BoxConstraints.expand() ,
          color:Color(0xFF383443) ,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              children: [
                Text(_todoName),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    itemCount: datalist.length,itemBuilder:
                      (_,index){
                    return CardUI(datalist[index].ten,datalist[index].email,datalist[index].phone);
                  },
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

  Future<String>getCurrentUID() async {
    return (await firebaseAuth.currentUser).uid;
  }
  Future<String> getData()
  async
  {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Users");
    final User user = firebaseAuth.currentUser;
    // var uid=getCurrentUID();
    final uid = user.uid;
    var team;
    reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print(values["name"]);
        team = values["name"];
      });
    });
    print(team);
  }
}
Widget CardUI(String ten,String email,String phone)
{
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
    child: Container(
      color: Color(0xFF383443),
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey,radius: 35,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ten,style: TextStyle(fontSize: 20,color: Colors.black),),
                      Text(email,style:  TextStyle(fontSize: 20,color: Colors.black),),
                      Text(phone)

                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );

}


