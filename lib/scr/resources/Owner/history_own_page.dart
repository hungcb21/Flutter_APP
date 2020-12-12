import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/accomplished_own_pag.dart';
import 'package:flutter_app/scr/resources/Owner/cancelled_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page.dart';
import 'package:flutter_app/scr/resources/Owner/waiting_own_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/login_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/main_menu_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/choose_time_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/demo_page.dart';

import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/sign_up_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/waiting_page.dart';
class HistoryOwn extends StatefulWidget {
  @override
  _HistoryOwnState createState() => _HistoryOwnState();
}

class _HistoryOwnState extends State<HistoryOwn> {
  final List<Widget> _childrenf =
  [
    Success(),
    WaitingOwn(),
    Cancelled(),
  ];
  @override
  Widget build(BuildContext context) {
    // return MaterialApp()
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xFF383443),
          elevation: 0,
          title: Center(child: Text("History")),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Success",),
              Tab(text: "Waiting",),
              Tab(text: "Cancelled",)
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

