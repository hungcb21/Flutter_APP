import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class Accompished extends StatefulWidget {
  @override
  _AccompishedState createState() => _AccompishedState();
}

class _AccompishedState extends State<Accompished> {
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  Query query;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var uid = firebaseUser.currentUser.uid;
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
      home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Colors.grey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child:FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: query,itemBuilder:(BuildContext context,
              DataSnapshot snapshot,Animation<double> animation,int index)
                  {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                    child: Text(snapshot.value["Time"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                                    child: Text(snapshot.value["Date"]),
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
                                child: Text(snapshot.value["NameStore"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                child: Text(snapshot.value["Address"]),
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
      ),
    );
  }
}
