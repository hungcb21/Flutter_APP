import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/choose_user_page.dart';
import 'package:flutter_app/scr/resources/Customer/update_infor_page.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String ten, sdt, email, image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("Users");
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
          image = values["Image"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(""),
            backgroundColor: Color(0xFF383443),
            bottom: AppBar(
              title: Text(
                "Account",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              backgroundColor: Color(0xFF383443),
            ),
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
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(image ??
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNK9yHOd59mG5Mq8YGD5l9xV-2MTXi2da9LA&usqp=CAU"),
                                radius: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ten ?? "",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    Text(
                                      "(+84${sdt}" ?? "",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      email ?? "",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
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
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 70,
                                ),
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
                              color: Colors.white),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 0, 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.account_circle_rounded,
                                      size: 70,
                                    ),
                                    Text(
                                      "Update info",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          160, 0, 0, 0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateInfor()));
                                          },
                                          child: Icon(Icons.arrow_forward_ios)),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset("images/Line 53.png"),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 0, 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.card_giftcard,
                                      size: 70,
                                    ),
                                    Text(
                                      "Your Coupon",
                                      style: TextStyle(fontSize: 20),
                                    ),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: SizedBox(
                          width: 140,
                          height: 40,
                          child: RaisedButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            onPressed: _signOut,
                            child: Text(
                              "Log out",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ));
  }
}

void _signOut() {
  FirebaseAuth.instance.signOut();
  runApp( MaterialApp(
    home: new ChooseUser(),
  ));
}
