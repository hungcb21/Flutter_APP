import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/choose_user_page.dart';
import 'package:flutter_app/scr/resources/Owner/login_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/updateinfo_own_page.dart';
class Account_Own extends StatefulWidget {
  @override
  _Account_OwnState createState() => _Account_OwnState();
}
class _Account_OwnState extends State<Account_Own> {
  String ten,sdt,email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("Onwners");
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final User user = firebaseAuth.currentUser;
    final uid = user.uid;
    reference.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          ten = values["name"];
          sdt = values["phone"];
          email = values["email"];
        });
      });
    });
  }
  @override
  FirebaseAuth firebaseAuth;

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Account",style: TextStyle(fontSize: 25,color: Colors.black),),
            backgroundColor: Colors.yellow,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            color: Color(0xFF383443),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 400,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white
                        ), child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ten??"",style: TextStyle(fontSize: 20,color: Colors.black),),
                                  Text("(+84)"+sdt??"",style: TextStyle(fontSize: 16,color: Colors.black),),
                                  Text(email??"",style: TextStyle(fontSize: 16,color: Colors.black),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                          height: 100,
                          width: 400,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Row(
                              children: [
                                Icon(Icons.qr_code, size: 70,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Your QR code"),
                                    Text("You can use this code to check in"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: Container(
                          width: 400,
                          height: 210,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.account_circle_rounded, size: 70,),
                                    Text("Update info",
                                      style: TextStyle(fontSize: 20),),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          160, 0, 0, 0),
                                      child: InkWell(
                                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_Info_Own()));},
                                          child: Icon(Icons.arrow_forward_ios)),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset("images/Line 53.png"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.card_giftcard, size: 70,),
                                    Text("Your Coupon",
                                      style: TextStyle(fontSize: 20),),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          150, 0, 0, 0),
                                      child: Icon(Icons.arrow_forward_ios),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 140,
                        height: 40,
                        child: RaisedButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15))),
                          onPressed: _signOut,
                          child: Text("Log out",
                            style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),
        )
    );
  }

}
void _signOut() {
  FirebaseAuth.instance.signOut();
  runApp(
      new MaterialApp(
        home: new ChooseUser(),
      )
  );
}
