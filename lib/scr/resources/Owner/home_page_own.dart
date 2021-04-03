import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/dashboard_page.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/list_chat_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/option_own_page.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_support/overlay_support.dart';
import 'account_owner_page.dart';
import 'dart:convert';
import 'dart:io' show Platform;

class HomePageOwn extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePageOwn> {
  String uid;
  FirebaseAuth auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _currentIndex = 0;
  int _counter=0;
  final List<Widget> _childrenf = [
    Dashboard(),
    OptionsOwn(),
    ChatListOwn(),
    Account_Own(),
  ];
  DateTime currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //lay token
    uid = auth.currentUser.uid;
    _firebaseMessaging.getToken().then((val) {
      DatabaseReference reference = FirebaseDatabase.instance.reference();
      reference.child("Stores").child(uid).update({'token': val});
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
        _counter++;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
        FlutterAppBadger.removeBadge();
        _counter++;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
        FlutterAppBadger.removeBadge();
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
          extendBodyBehindAppBar: false,
          body: _childrenf[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
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
                  icon: Icon(Icons.assistant_outlined, color: Colors.black),
                  label: "Options",
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: (){setState(() {
                      _counter==0;
                    });},
                    child: Stack(
                      children:[
                        Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        Positioned(
                            right: 0,
                            child: new Container(
                                padding: EdgeInsets.all(1),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: new Text(
                                  '$_counter',
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                            ),
                        ),
                      ]
                    ),
                  ),
                  label: "Message",
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_sharp,
                    color: Colors.black,
                  ),
                  label: "Account",
                  backgroundColor: Colors.white),
            ],
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


    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: json.encode(message));

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }
}
