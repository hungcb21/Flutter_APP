import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/chat_screen.dart';
class ChatListOwn extends StatefulWidget {
  @override
  _ChatListOwnState createState() => _ChatListOwnState();
}

class _ChatListOwnState extends State<ChatListOwn> {
  Query query;
  String uid,name,avatar;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uid=auth.currentUser.uid;
    query = FirebaseDatabase.instance.reference().child("Stores").child(uid).child("Chat");
    DatabaseReference comment =
    FirebaseDatabase.instance.reference().child("Stores");
    comment.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          name = values["NameStore"];
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
          backgroundColor: Colors.yellow,
          title: Text("Message",style: TextStyle(fontSize: 25,color: Colors.black),),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: FirebaseAnimatedList(
            query: query,
            itemBuilder:(BuildContext context,
                DataSnapshot snapshot,
                Animation<double> animation,
                int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(snapshot.value["idRoomChat"],avatar,name)));
                  },
                  child: Container(
                    height: 100,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: new NetworkImage(snapshot.value["cusImage"]),
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
                                snapshot.value["cusName"]??"",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.value["lastMessenger"]??"",
                                style: TextStyle(color: Colors.black45),
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
