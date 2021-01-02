import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class SetTime extends StatefulWidget {
  @override
  _SetTimeState createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  Query query;
  DatabaseReference ref = FirebaseDatabase.instance.reference().child('Demo');

  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  DataSnapshot snapshot;
  FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String UID = _fireBaseAuth.currentUser.uid;
    query= FirebaseDatabase.instance.reference().child("Stores").child(UID).child("Time");
    ref =  FirebaseDatabase.instance.reference().child("Stores").child(UID).child("Time");
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
          child: SingleChildScrollView(
            child: Column(
                children:<Widget> [
                  Center(
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                              child: Text("Thêm thời gian",style: TextStyle(fontSize: 20),),
                            ),
                            TextField(
                              style: TextStyle(fontSize: 18,color: Colors.black),
                              controller: _userController,
                              decoration: InputDecoration(labelText: "Thời gian",
                                  hintText: "Thời gian phải có AM hoặc PM VD:7.00AM",
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
                                  child: Text("Thêm",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ),
                            Container(
                              width: 400,
                              height: 400,
                              child: FirebaseAnimatedList(
                                shrinkWrap: true,

                                      query: query,itemBuilder:(BuildContext context,
                                          DataSnapshot snapshot,Animation<double> animation,int index){
                                        Map demo= snapshot.value;
                                        return new ListTile(
                                          trailing: IconButton(icon: Icon(Icons.delete),onPressed: ()=>
                                              ref.child(snapshot.key).remove(),),
                                          title: new Text(snapshot.value["time"]+"\n"),
                                          onTap: (){
                                            String ten = _userController.text;
                                            ref.child(snapshot.key).update({
                                              'ten':ten
                                            }).then((value) { _userController.text="";});},
                                        );
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
            ),
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
    };
    ref.push().set(demo).then((value) {
      _userController.text="";
    });

  }
}
