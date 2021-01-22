import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Accompished extends StatefulWidget {
  @override
  _AccompishedState createState() => _AccompishedState();
}

class _AccompishedState extends State<Accompished> {
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  Query query;
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid = firebaseUser.currentUser.uid;
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Users").child(uid).child("Success");
    query=  FirebaseDatabase.instance.reference().child("Users").child(uid).child("Success");
    // reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
    //   Map<dynamic,dynamic> values = snapshot.value;
    //   values.forEach((key,values) {
    //     print(values["pass"]);
    //
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child:FirebaseAnimatedList(
                  shrinkWrap: true,
                  reverse: true,
                  query: query,itemBuilder:(BuildContext context,
              DataSnapshot snapshot,Animation<double> animation,int index)
                  {
                    return InkWell(
                      onLongPress: (){
                        final action = CupertinoActionSheet(
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text("Xóa khỏi lịch sử"),
                              isDefaultAction: true,
                              onPressed: () {
                                DatabaseReference refx=FirebaseDatabase.instance.reference();
                                refx.child("Users").child(uid).child("Success").child(snapshot.key).remove();
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("Xóa tất cả khỏi lịch sử"),
                              isDestructiveAction: true,
                              onPressed: () {
                                DatabaseReference refx=FirebaseDatabase.instance.reference();
                                refx.child("Users").child(uid).child("Success").remove();
                                Navigator.of(context, rootNavigator: true).pop();
                              },
                            )
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        );
                        showCupertinoModalPopup(
                            context: context, builder: (context) => action);
                      },
                      child: Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                    child: Text("Time: "+snapshot.value["Time"],style: TextStyle(fontSize: 15),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                    child: Text("Date: "+snapshot.value["Date"],style: TextStyle(fontSize: 15),),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset("images/C4 1.png"),
                                    Image.asset("images/C2 1.png"),
                                    Image.asset("images/Cap1 1.png")
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                child: Text("Barbershop :"+snapshot.value["NameStore"],style: TextStyle(fontSize: 15),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
                                child: Text("Brach :"+snapshot.value["Address"],style: TextStyle(fontSize: 15),),
                              ),
                            ],
                          )
                      ),
                    );
                  }
              ),
            ),

        ),
      ),
    );
  }
}
