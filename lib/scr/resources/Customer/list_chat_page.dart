import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/chat_screen.dart';

class ChatListCus extends StatefulWidget {
  @override
  _ChatListCusState createState() => _ChatListCusState();
}

class _ChatListCusState extends State<ChatListCus> {
  Query query;
  String uid, name, avatar,tokenStore;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    uid = auth.currentUser.uid;
    query = FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(uid)
        .child("Chat");
    DatabaseReference comment =
        FirebaseDatabase.instance.reference().child("Users");
    comment.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          name = values["name"];
          avatar = values["Image"];
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
          backgroundColor: Color(0xFF383443),
          title: Text("Chat"),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: FirebaseAnimatedList(
            query: query,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    DatabaseReference reference = FirebaseDatabase.instance.reference();
                    reference.child("Stores").child(snapshot.value["storeUid"]).once().then((value) {
                      Map<dynamic, dynamic> values = value.value;
                      setState(() {
                        tokenStore=values["token"];
                        print("token ne:"+tokenStore);
                      });

                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                snapshot.value["idRoomChat"], avatar, name,tokenStore)));
                  },
                  child: Container(
                    height: 100,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              new NetworkImage(snapshot.value["storeImage"]),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.value["storeName"] ?? "",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.value["lastMessenger"] ?? "",
                                style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
