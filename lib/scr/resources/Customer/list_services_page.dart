import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class ListServices extends StatefulWidget {
  @override
  _ListServicesState createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){},
      ),),
      body: Container(
        constraints: BoxConstraints.expand(),
        child:FirebaseAnimatedList(
          itemBuilder: (BuildContext context,DataSnapshot snapshot,Animation<double> animation,int index){

          },
        ) ,
      ),
    );
  }
}
