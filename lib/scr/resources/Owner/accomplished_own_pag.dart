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
  List<UserProfile> datalist=[];
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  Query query;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var uid = firebaseUser.currentUser.uid;
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Stores").child(uid).child("Success");
    query=  FirebaseDatabase.instance.reference().child("Stores").child(uid).child("Success");
    // reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
    //   Map<dynamic,dynamic> values = snapshot.value;
    //   values.forEach((key,values) {
    //     print(values["pass"]);
    //
    //   });
    // });
    reference.once().then((DataSnapshot dataSnapshot){
      datalist.clear();
      var keys= dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      // reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      //   Map<dynamic,dynamic> values = snapshot.value;
      //   values.forEach((key,values) {
      //     print(values["pass"]);
      //   });
      // });
      for(var key in keys)

      {
        UserProfile data=new UserProfile(
          values [key]["name"],
          values [key]["email"],
          values [key]["phone"],

        );
        datalist.add(data);
      }
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body:
          FirebaseAnimatedList(shrinkWrap: true,
              query: query,itemBuilder:(BuildContext context,
                  DataSnapshot snapshot,Animation<double> animation,int index)
              {
                return InkWell(
                  onTap: (){},
                  child: Card(
                      elevation: 10,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget>[
                            Row(

                              children: [
                                Icon(Icons.account_circle_sharp),
                                Column(
                                  children: [
                                    Text(snapshot.value["NameCustomer"],style: TextStyle(fontSize: 15),),
                                    Text("(+84)"+snapshot.value["PhoneCustomer"],style: TextStyle(fontSize: 15),),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                                  child: Text(snapshot.value["Day"]+" "+snapshot.value["Time"],style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.add_location),
                                Text(snapshot.value["Address"],style: TextStyle(fontSize: 15)),
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                );
              })
        // ListView.builder(
        //    itemCount: datalist.length,itemBuilder:
        //      (_,index){
        //    return CardUI(datalist[index].ten,datalist[index].phone);
        //  },
        //  ),

      ),
    );
  }
}
Widget CardUI(String name,String phone)
{
  return  InkWell(
    onTap: (){},
    child: Card(
        elevation: 10,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              Row(
                children: [
                  Icon(Icons.account_circle_sharp),
                  Column(
                    children: [
                      Text(name,style: TextStyle(fontSize: 15),),
                      Text(phone,style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(160, 0, 0, 0),
                    child: Text("Today 9.00",style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.add_location),
                  Text(name,style: TextStyle(fontSize: 15)),
                ],
              )
            ],
          ),
        )
    ),
  );
}

