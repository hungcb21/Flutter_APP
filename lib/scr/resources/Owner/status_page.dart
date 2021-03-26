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
    DatabaseReference reference = FirebaseDatabase.instance.reference().child(
        "Stores").child(uid).child("Waiting");
    query =
        FirebaseDatabase.instance.reference().child("Stores").child(uid).child(
            "Waiting");
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePageOwn()));
            },
            child: Container(
              child: Image.asset("images/left-arrow2.png"),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Colors.yellow,
                child: Text("Status", style: TextStyle(fontSize: 30),),
              ),
              preferredSize: Size.fromHeight(kToolbarHeight)),
        ),
        body: Container(
            child: FirebaseAnimatedList(
                shrinkWrap: true,
                query: query, itemBuilder: (BuildContext context,
                DataSnapshot snapshot, Animation<double> animation, int index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Status2(index, snapshot.key)));
                  },
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
                                    image: NetworkImage(snapshot.value["ImageCus"]??"https://scontent.fsgn2-1.fna.fbcdn.net/v/t1.0-9/50396385_2259091907660313_3015233235551518720_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=xGJfZO9JJ6YAX_qkB1F&_nc_oc=AQnBnelsr-cjza5f0d_d0-kR6F66v5NHIYfiVpVFoE-wXsc84fzXFroMNWMF-75cXUzJnojd_DMcl-OwTM9CoA7i&_nc_ht=scontent.fsgn2-1.fna&oh=5dca84a0d4035c8502dc22563aee3694&oe=60835979"))),
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
            }
            )
        ),
      ),
    );
  }
}
