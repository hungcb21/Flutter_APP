import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}
class _DemoState extends State<Demo> {
  Query query;
  DatabaseReference ref = FirebaseDatabase.instance.reference().child('Demo');
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  DataSnapshot snapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query= FirebaseDatabase.instance.reference().child('Demo');
    ref = FirebaseDatabase.instance.reference().child("Demo");
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Demo"),
        ),
        body: SingleChildScrollView(
                child: Column(
                  children:<Widget> [
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                              child: Text("Go gi do di"),
                            ),
                            TextField(
                              style: TextStyle(fontSize: 18,color: Colors.black),
                              controller: _userController,
                              decoration: InputDecoration(labelText: "1",
                                  labelStyle:TextStyle( color: Colors.black,fontSize:18)),
                            ),
                            TextField(
                              style: TextStyle(fontSize: 18,color: Colors.black),
                              controller: _passController,
                              decoration: InputDecoration(labelText: "12",
                                  labelStyle:TextStyle( color: Colors.black,fontSize:18)),
                            ),
                           Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: SizedBox(
                                width: 140,
                                height: 40,
                                child: RaisedButton(
                                  color: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                                  onPressed:onLoginCliked,
                                  child: Text("Login",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ),
                           Flexible(
                                  child: FirebaseAnimatedList(shrinkWrap: true,
                                    query: query,itemBuilder:(BuildContext context,
                                        DataSnapshot snapshot,Animation<double> animation,int index){
                                      Map demo= snapshot.value;
                                      return new ListTile(
                                        trailing: IconButton(icon: Icon(Icons.accessible_rounded),onPressed: ()=>
                                            ref.child(snapshot.key).remove(),),
                                        title: new Text(snapshot.value["time"]+"\n"+snapshot.key),
                                        onTap: (){
                                          String ten = _userController.text;
                                          ref.child(snapshot.key).update({
                                          'ten':ten
                                        }).then((value) { _userController.text="";});},
                                      );
                                    },
                                  )
                              ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              ),
      );

  }
  onLoginCliked(){
    String ten = _userController.text;
    String time = _passController.text;
    Map<String,String> demo ={
      'time':ten,
      'status':time,
    };
    ref.push().set(demo).then((value) {
      _userController.text="";
    });

  }


}
