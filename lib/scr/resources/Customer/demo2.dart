import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Class/DataDemo.dart';
import '../Class/TimeClass.dart';
class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}
class _Demo2State extends State<Demo2> {
  String ten2;
  List<Time> datalist=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Demo");
    reference.orderByKey().equalTo(ten2).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print(values["pass"]);
      });
    });
    reference.once().then((DataSnapshot dataSnapshot){
      datalist.clear();
      var keys= dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for(var key in keys)
      {
        Time data=new Time(
            values[key]["time"],
            values[key]["status"]
        );
        datalist.add(data);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemCount: datalist.length,itemBuilder:
            (_,index){
          return CardUI(datalist[index].time,datalist[index].status);
        },
        )
      ),
    );
  }

}
Widget CardUI(String time,String status)
{
  return InkWell(
    onTap: (){},
    child: Card(
        elevation: 10,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Text("8:30AM"),
              Text("Full"),
            ],
          ),
        )
    ),
  );
}

