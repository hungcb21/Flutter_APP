import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/list_chat_page.dart';
import 'package:flutter_app/scr/resources/Customer/options_page.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/account_page.dart';

import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/hitory_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/list_store_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  String uid;
  DateTime currentBackPressTime;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _currentIndex = 0;
  final List<Widget> _childrenf = [
    ListStore(),
    Account(),
    Options(),
    History(),
    ChatListCus(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //lay token
    uid= auth.currentUser.uid;
    _firebaseMessaging.getToken().then((val) {
      DatabaseReference reference = FirebaseDatabase.instance.reference();
      reference.child("Users").child(uid).update({
        'token': val
      });
    });
    //nhan thong bao
    if (Platform.isIOS) {
      _firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
        FlutterAppBadger.updateBadgeCount(1);

      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
        FlutterAppBadger.removeBadge();
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: "Bấm 2 lần để thoát");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(child: _childrenf[_currentIndex]),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.black,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: TextStyle(color: Colors.black))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              // selectedItemColor: Colors.white,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    label: "Home",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle, color: Colors.black),
                    label: "Account",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assistant_outlined, color: Colors.black),
                  label: "Options",
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.history,
                      color: Colors.black,
                    ),
                    label: "History",
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                    label: "Chat",
                    backgroundColor: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.domain.myapplication'
          : 'com.domain.myapplication',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }
}
