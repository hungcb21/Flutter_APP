import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/dashboard_page.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/list_chat_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/option_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'account_owner_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/account_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/choose_time_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/demo2.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/hitory_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/login_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/sign_up_page.dart';
class HomePageOwn  extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePageOwn> {

  int _currentIndex = 0;
  final List<Widget> _childrenf=
  [
    Dashboard(),
    OptionsOwn(),
    Dashboard(),
    ChatListOwn(),
    Account_Own(),
  ];
  DateTime currentBackPressTime;
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
            onTap: (int index){setState(() {
              _currentIndex= index;
            });},
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home,color: Colors.black,),
                  label: "Home",
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assistant_outlined,color: Colors.black),
                  label: "Options",
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notification_important,color: Colors.black),
                  label: "Notification",
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.mail,color: Colors.black,),
                  label: "Message",
                  backgroundColor: Colors.blue
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_sharp,color: Colors.black,),
                  label: "Account",backgroundColor: Colors.blue

              ),
            ],
          ),
        ),
      ),
    );
  }


}


