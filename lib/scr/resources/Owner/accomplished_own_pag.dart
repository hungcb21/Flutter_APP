import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/UserClass.dart';

class Success extends StatefulWidget {
  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  List<UserProfile> datalist = [];
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  Query query;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var uid = firebaseUser.currentUser.uid;
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(uid)
        .child("Success");
    query = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(uid)
        .child("Success");
    // reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
    //   Map<dynamic,dynamic> values = snapshot.value;
    //   values.forEach((key,values) {
    //     print(values["pass"]);
    //
    //   });
    // });
    reference.once().then((DataSnapshot dataSnapshot) {
      datalist.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      // reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      //   Map<dynamic,dynamic> values = snapshot.value;
      //   values.forEach((key,values) {
      //     print(values["pass"]);
      //   });
      // });
      for (var key in keys) {
        UserProfile data = new UserProfile(
          values[key]["name"],
          values[key]["email"],
          values[key]["phone"],
        );
        datalist.add(data);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: FirebaseAnimatedList(
              reverse: true,
              shrinkWrap: true,
              query: query,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return InkWell(
                  onTap: () {},
                  child: Card(
                    shape: BeveledRectangleBorder(),
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                    shadowColor: Colors.black87,
                    elevation: 8.0,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Container(
                            width: 90.0,
                            height: 85.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.value["ImageCus"]??"https://lh3.googleusercontent.com/proxy/jhsYOeTSa2GfDATuLX-nkw3KxrHEr9rhWigrI1CAr6V1AS6EgcICo2k58uqvs1YjKjm2sa3MU1Oyx2iV-S8WdqUHEn6wDlQJnAEEiQUYYXpp-aGu"))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5.0),
                          // width: 220.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 5.0),
                              Row(children: <Widget>[
                                Icon(
                                  Icons.person,
                                  color: Theme.of(context)
                                      .bottomAppBarTheme
                                      .color,
                                  size: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    snapshot.value["NameCustomer"] ?? '',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.5),
                                  ),
                                )
                              ]),
                              SizedBox(height: 5.0),
                              Row(children: <Widget>[
                                Icon(
                                  Icons.phone,
                                  color: Theme.of(context)
                                      .bottomAppBarTheme
                                      .color,
                                  size: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "(+84)" +
                                            snapshot.value["PhoneCustomer"] ??
                                        "",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.5),
                                  ),
                                )
                              ]),
                              SizedBox(height: 5.0),
                              Row(children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(context)
                                      .bottomAppBarTheme
                                      .color,
                                  size: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    snapshot.value["Day"] +
                                        " " +
                                        snapshot.value["Time"],
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.5),
                                  ),
                                )
                              ]),
                              SizedBox(height: 5.0),
                              Row(children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context)
                                      .bottomAppBarTheme
                                      .color,
                                  size: 15.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    width: 190,
                                      child: Text(
                                    snapshot.value["Address"] ?? "",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 13.5),
                                    textAlign: TextAlign.left,
                                  )),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
