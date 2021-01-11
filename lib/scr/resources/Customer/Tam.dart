import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _textController = TextEditingController();

  String iOSDevice = 'e0rt5GJxQXCIyJWzZL4qnq:APA91bG3SvJVbD3trWq-qNWzhlJnTh0tKkAXpa2ugReNzCvnfpr-cFr7hbJ-rl1yGh9yUKyuX1iqu26H-bp2VCq-eUlZnp1A-oGdMpbGAT89ymFIXMzVainLi0ELIPjX9EGEpkIqY48U';
  String androidSimul = 'fNb83UmUTK-uRlQhw2O_tC:APA91bEma451mR4zbYQM4sIx_K-MXVfw1VsLffLBLCOETEuuBZPgoaxqP63z3c-LvUQW4xCw4JvgVTUQjGKLZOWpMTXaKnZqOX2RZffIMH7j6pHdFiEsDDlGjJzTKumFzuztCwni7dYh';

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings());
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sdasd"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Get Token',
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                _firebaseMessaging.getToken().then((val) {
                  print('Token: '+val);
                });
              },
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 260,
              child: TextFormField(
                validator: (input) {
                  if(input.isEmpty) {
                    return 'Please type an message';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Message'
                ),
                controller: _textController,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Send a message to Androidsadsda',
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                sendAndRetrieveMessage(androidSimul);
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Send a message to iOS',
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                sendAndRetrieveMessage(iOSDevice);
              },
            )
          ],
        ),
      ),
    );
  }

  final String serverToken = 'AAAAE20gnpk: APA91bFXei1SgxBwx7roKJBTlQ8VI2WoDv3nng1SOT3CdRmAmhJwkzExUYL7aHSkJkuK1nTKOa1tyUe7QRZ4NDyx-WW52woDv3nng1SOT3CdRmAmhJwkzExUYL7aHSkJkuK1nTKOa1tyUe7QRZ4NDyx-WW52w324ChnoThLoT843EUZTM4NDyx-WW52w324ChnoThLoZ5tm';

  Future<Map<String, dynamic>> sendAndRetrieveMessage(String token) async {
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': "sad",
            'title': 'FlutterCloudMessage'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '10',
            'status': 'done'
          },
          'to': token,
        },
      ),
    );

    _textController.text = '';
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