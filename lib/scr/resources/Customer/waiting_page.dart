
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/choose_time_page.dart';
class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  DatabaseReference reference2 = FirebaseDatabase.instance.reference();
  String storeUid;
  String nameCustomer,phoneCustomer,emailCustomer;
  Query query;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userUID = _firebaseAuth.currentUser.uid;
    var uid = _firebaseAuth.currentUser.uid;
    reference2 = FirebaseDatabase.instance.reference().child("Users");
    databaseReference = FirebaseDatabase.instance.reference().child("Users")
        .child(userUID)
        .child("Waiting");
    reference2.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        setState(() {
          nameCustomer = values["name"];
          phoneCustomer = values["phone"];
          emailCustomer= values["email"];
        });
      });
    });
    query = FirebaseDatabase.instance.reference().child("Users")
        .child(userUID)
        .child("Waiting");
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
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: FirebaseAnimatedList(
                            shrinkWrap: true,
                            query: query, itemBuilder: (BuildContext context,
                            DataSnapshot snapshot, Animation<double> animation,
                            int index) {
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
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 30, 30, 0),
                                          child: Text("Time "+":"+snapshot.value["Time"],style: TextStyle(fontSize: 15),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 30, 30, 0),
                                          child: Text("Date "+":"+snapshot.value["Date"],style: TextStyle(fontSize: 15),),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 40, 0, 40),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Image.asset("images/C4 1.png"),
                                          Image.asset("images/C2 1.png"),
                                          Image.asset("images/Cap1 1.png")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 0, 0),
                                      child: Text("BarberShop "+":"+snapshot.value["NameStore"],style: TextStyle(fontSize: 15),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 0, 0),
                                      child: Text("Brach "+":"+snapshot.value["Address"]+","+snapshot.value["District"]+","+snapshot.value["City"],style: TextStyle(fontSize: 15),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 30, 0, 0),
                                            child: SizedBox(
                                              width: 140,
                                              height: 40,
                                              child: RaisedButton(
                                                color: Colors.blueAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8))),
                                                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseTime(snapshot.key,snapshot.value["NameStore"],snapshot.value["Address"],snapshot.value["District"],snapshot.value["City"])));},
                                                child: Text("Change schedule",
                                                  style: TextStyle(
                                                      color: Colors.white),),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                30, 30, 0, 0),
                                            child: SizedBox(
                                              width: 140,
                                              height: 40,
                                              child: RaisedButton(
                                                color: Colors.blueAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8))),
                                                onPressed: () {  setState(() {
                                                  storeUid=snapshot.key;
                                                });
                                                AlertDialog alert = AlertDialog(
                                                  title: Text("Hủy đặt chỗ"),
                                                  content: Text("Bạn có muốn hủy đặt chỗ ?"),
                                                  actions: <Widget>[
                                                  FlatButton(
                                                    child: Text("Không"),
                                                    onPressed: (){Navigator.of(context, rootNavigator: true).pop();}
                                                  ),
                                                  FlatButton(
                                                    child: Text("Có"),
                                                    onPressed:  () {
                                                      DatabaseReference ref = FirebaseDatabase.instance.reference().child("Stores").child(storeUid).child("Cancel");
                                                      Map<String,String> demo ={
                                                        'NameCustomer':nameCustomer,
                                                        'EmailCustomer':emailCustomer,
                                                        'PhoneCustomer':phoneCustomer,
                                                        'Date':snapshot.value["Date"],
                                                        'Address':snapshot.value["Address"],
                                                        'District':snapshot.value["District"],
                                                        'City':snapshot.value["District"],
                                                        'Time':snapshot.value["Time"],
                                                      };
                                                      ref.push().set(demo);
                                                    databaseReference.child(snapshot.key).remove();
                                                      Navigator.of(context, rootNavigator: true).pop();},
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
                                                child: Text("Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          );
                        }
                        )
                    ),
                  ],
                ),
              ),
          ),
        ),
      );
    }
  onCancelCliked(){
    // Map<String,String> demo ={
    //
    // };
    // ref.push().set(demo).then((value) {
    //   _userController.text="";
    // });

  }
  }
