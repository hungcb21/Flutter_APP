import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/dashboard_page.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/list_chat_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/option_own_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final List<Widget> _childrenf = [
    Dashboard(),
    OptionsOwn(),
    Dashboard(),
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
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
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
          Fluttertoast.showToast(msg: "Bam 2 lan de thoat");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          extendBodyBehindAppBar: false,
          // appBar: AppBar(
          //   backgroundColor: Colors.yellow,
          //   elevation: 0,
          //   // leading:   InkWell(
          //   //   onTap: () {Navigator.of(context).pushAndRemoveUntil(
          //   //       MaterialPageRoute(builder: (c) => HomePageOwn()),
          //   //           (route) => false);},
          //   //   child: Container(
          //   //     child: Image.asset("images/left-arrow2.png"),
          //   //   ),
          //   // ),
          //   // actions: [
          //   //   InkWell(
          //   //     onTap: () {},
          //   //     child: Container(
          //   //       child: Image.asset("images/magnifying-glass 1.png"),
          //   //     ),
          //   //   ),
          //   // ],
          // ),
          body: _childrenf[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
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
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assistant_outlined, color: Colors.black),
                  label: "Options",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notification_important, color: Colors.black),
                  label: "Notification",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  label: "Message",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle_sharp,
                    color: Colors.black,
                  ),
                  label: "Account",
                  backgroundColor: Colors.blue),
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
