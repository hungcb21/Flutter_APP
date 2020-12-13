import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/account_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/choose_time_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/demo2.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/demo_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/hitory_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/list_store_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/login_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/sign_up_page.dart';
class HomePage  extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {

  int _currentIndex = 0;
  final List<Widget> _childrenf=
  [ ListStore(),
    Status(),
    Demo(),
    History(),
    History(),

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         leading:   InkWell(
           onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));},
           child: Container(
             child: Image.asset("images/left-arrow2.png"),
           ),
         ),
         actions: [
           InkWell(
             onTap: () {},
             child: Container(
               child: Image.asset("images/magnifying-glass 1.png"),
             ),
           ),
         ],
       ),
         body: _childrenf[_currentIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.white,
              primaryColor: Colors.black,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(color: Colors.black)
              )
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            // selectedItemColor: Colors.white,
            onTap: (int index){setState(() {
              _currentIndex= index;
            });},
            items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black,),
            label:"Home",
            backgroundColor: Colors.white
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,color: Colors.black),
            label: "Account",
                backgroundColor: Colors.white
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.assistant_outlined,color: Colors.black),
            label: "Options",
                backgroundColor: Colors.white,

          ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.autorenew_outlined,color: Colors.black,),
                  label: "History",
                  backgroundColor: Colors.white
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.waves_outlined,color: Colors.black,),
                  label: "Menu",backgroundColor: Colors.white

              ),
            ],
          ),
        ),
        ),
    );
  }


}


