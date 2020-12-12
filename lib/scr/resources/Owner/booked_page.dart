import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/UserClass.dart';
class Booked extends StatelessWidget {
  List<UserProfile> datalist=[];

  @override
  Widget build(BuildContext context) {
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Users");
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // firebaseUser = firebaseAuth.currentUser;
    final User user = firebaseAuth.currentUser;
    // var uid=getCurrentUID();
    final uid = user.uid;
    final email1= user.phoneNumber;
    String ten12;
    reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        print(values["pass"]);
        print(values["name"]);
        ten12= values["phone"];
      });
    });

    reference.once().then((DataSnapshot dataSnapshot){
      datalist.clear();
      var keys= dataSnapshot.value.keys;
      var values = dataSnapshot.value;
     reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot){
        Map<dynamic,dynamic> values = snapshot.value;
        values.forEach((key,values) {
          print(values["phone"]);
          ten12 = values[key]["phone"];
        });

      });
      reference.child("Users").once().then((DataSnapshot data){
        print(data.value);
        print(data.key);

      });
      for(var key in keys)
      {
        UserProfile data=new UserProfile(
          values [key]["name"],
          values [key]["email"],
          values [key]["phone"],

        );

        datalist.add(data);
      }
    });
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text("ok")??ListView.builder(
                  itemCount: datalist.length,itemBuilder:
                    (_,index){
                  return CardUI(datalist[index].ten,datalist[index].phone);
                },
                ),
              ),
            ],
          ),
        )
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