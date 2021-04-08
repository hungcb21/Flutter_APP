import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/widget/ChatMessageListItem.dart';

import 'package:image_picker/image_picker.dart';

final auth = FirebaseAuth.instance;
var currentUserEmail;
var _scaffoldContext;

class ChatScreen extends StatefulWidget {
  String uids,avatar,name,token;
  ChatScreen(this.uids,this.avatar,this.name,this.token);

  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  final String serverToken = '	AAAAE20gnpk:APA91bFWWMS8ocapsunPLjwB4i7xAfJ-VTW9Nq0YROTIudvwnGofqc5K8LWmRoy0YKQEaCTri3Ezrr65duFXx4feUKnqylt6X6M1892mAXcFeMZFYlCcUqV1kvsXolg6vobI_6HiJdVB';
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool _isComposingMessage = false;
  var email;
  var uid;
  FirebaseAuth auth = FirebaseAuth.instance;
  Query query;
  String uidCus,uidOwn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = auth.currentUser.email;
    uid = auth.currentUser.uid;
    query = FirebaseDatabase.instance.reference().child("Chat").child(widget.uids).child("Content");
    DatabaseReference comment = FirebaseDatabase.instance.reference().child("Chat");
    comment.orderByKey().equalTo(widget.uids).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      var key = snapshot.key;
      values.forEach((key, values) {
        setState(() {
          uidCus = values["cusUID"];
          uidOwn = values["ownUID"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
          appBar: new AppBar(
            backgroundColor: Color(0xFF383443),
            leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          ),
          body: new Container(
            child: new Column(
              children: <Widget>[
                new Flexible(
                  child: new FirebaseAnimatedList(
                    query: query,
                    padding: const EdgeInsets.all(8.0),
                    reverse: true,
                    sort: (a, b) => b.key.compareTo(a.key),
                    //comparing timestamp of messages to check which one would appear first
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      return ChatMessageListItem(
                          messageSnapshot: snapshot, animation: animation);
                    },
                  ),
                ),
                new Divider(height: 1.0),
                new Container(
                  decoration:
                      new BoxDecoration(color: Theme.of(context).cardColor),
                  child: _buildTextComposer(),
                ),
                new Builder(builder: (BuildContext context) {
                  _scaffoldContext = context;
                  return new Container(width: 0.0, height: 0.0);
                })
              ],
            ),
            decoration: Theme.of(context).platform == TargetPlatform.iOS
                ? new BoxDecoration(
                    border: new Border(
                        top: new BorderSide(
                    color: Colors.grey[200],
                  )))
                : null,
          )),
    );
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed:
        () {
        if(_isComposingMessage==true)
          {
               _textMessageSubmitted(_textEditingController.text);
          }
    }

    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).accentColor
              : Theme.of(context).disabledColor,
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () async {
                      final _picker = ImagePicker();
                      PickedFile image =
                          await _picker.getImage(source: ImageSource.gallery);
                      var imageFile = File(image.path);
                      int timestamp = new DateTime.now().millisecondsSinceEpoch;
                      final storageReference = FirebaseStorage.instance;
                      var uploadTask = await storageReference
                          .ref()
                          .child("img_" + timestamp.toString() + ".jpg")
                          .putFile(imageFile);
                      var downloadUrl = await uploadTask.ref.getDownloadURL();
                      _sendMessage(
                          messageText: null, imageUrl: downloadUrl.toString());
                    }),
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? getIOSSendButton()
                    : getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }

  _textMessageSubmitted(String text)  {
    setState(() {
      _isComposingMessage = false;
    });

    _sendMessage(messageText: text, imageUrl: null);

  }

  void _sendMessage({String messageText, String imageUrl}) {
    sendAndRetrieveMessage(messageText);
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Chat").child(widget.uids).child("Content");
    reference.push().set({
      'text': messageText,
      'uid': uid,
      'imageUrl': imageUrl,
      'senderName': widget.name,
      'senderPhotoUrl':widget.avatar,

    });
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("Users").child(uidCus).child("Chat").child(widget.uids).update(
        {
          'lastMessenger': messageText
        }
    );
    ref.child("Stores").child(uidOwn).child("Chat").child(widget.uids).update(
        {
          'lastMessenger': messageText
        }

    );

    _textEditingController.clear();
    // analytics.logEvent(name: 'send_message');
  }
  Future<Map<String, dynamic>> sendAndRetrieveMessage(message) async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '${message}',
            'title': '${widget.name}'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await widget.token,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
    return completer.future;
  }
}
