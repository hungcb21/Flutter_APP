import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  String iOSDevice = 'f4k6FjnTSNy2C3s5FobWPr:APA91bHg5P9VKAlISOSUcfOsFTkafX5CnsmZFE1dPYUjT_ZmQCf3RgDzfdyieBhVSR0Sb2Uot_jHDpckJrKuBz0abO5LHWbCUmbPOkQIpBsXhTViLJDkpRDAnkkMn5rnV6buW-MRoZ13';
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
        Platform.isAndroid ? showNotification(message['notification']) : showNotification(message['aps']['alert']);
      },

      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.domain.myapplication' : 'com.domain.myapplication',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics =
    new NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(
        0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
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
              child: Text('Send a message to Android',
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                sendAndRetrieveMessage();
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Send a message to iOS',
                  style: TextStyle(fontSize: 20)),
              onPressed: () {
                sendAndRetrieveMessage();
              },
            )
          ],
        ),
      ),
    );
  }

  final String serverToken = '	AAAAE20gnpk:APA91bFWWMS8ocapsunPLjwB4i7xAfJ-VTW9Nq0YROTIudvwnGofqc5K8LWmRoy0YKQEaCTri3Ezrr65duFXx4feUKnqylt6X6M1892mAXcFeMZFYlCcUqV1kvsXolg6vobI_6HiJdVB';

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
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
            'body': 'Hung day',
            'title': 'Da gui dc'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await '$androidSimul',
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