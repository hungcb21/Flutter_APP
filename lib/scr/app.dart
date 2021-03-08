import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/Tam.dart';
import 'package:flutter_app/scr/resources/Customer/account_page.dart';
import 'package:flutter_app/scr/resources/Customer/choose_time_page.dart';
import 'package:flutter_app/scr/resources/Customer/choose_user_page.dart';
import 'package:flutter_app/scr/resources/Customer/demo2.dart';
import 'package:flutter_app/scr/resources/Customer/hitory_page.dart';
import 'package:flutter_app/scr/resources/Customer/list_store_page.dart';
import 'package:flutter_app/scr/resources/Customer/login_page.dart';
import 'package:flutter_app/scr/resources/Customer/main_menu_page.dart';
import 'package:flutter_app/scr/resources/Customer/options_page.dart';
import 'package:flutter_app/scr/resources/Customer/update_infor_page.dart';
import 'package:flutter_app/scr/resources/Customer/waiting_page.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/home_page_own.dart';
import 'package:flutter_app/scr/resources/Owner/login_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/set_time_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page2.dart';
import 'package:flutter_app/scr/resources/Owner/waiting_own_page.dart';

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}