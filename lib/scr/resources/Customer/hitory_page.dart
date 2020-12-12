import 'package:flutter/material.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/login_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/main_menu_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/choose_time_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/demo_page.dart';

import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/sign_up_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/waiting_page.dart';
import 'package:flutter_app/scr/resources/Customer/accomplished_page.dart';
class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List<Widget> _childrenf =
  [
    Waiting(),
    Accompished(),
  ];
  @override
  Widget build(BuildContext context) {
    // return MaterialApp()
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFF383443),
          elevation: 0,
          title: Center(child: Text("History")),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Waiting",),
              Tab(text: "Accomplished",)
            ],
          ),
        ),
        body: TabBarView(
          children: _childrenf,
        ),
      ),


    );
  }
}
