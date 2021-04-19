import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/Tam.dart';
import 'package:flutter_app/scr/resources/Customer/account_page.dart';
import 'package:flutter_app/scr/resources/Customer/choose_time_page.dart';
import 'package:flutter_app/scr/resources/Customer/choose_user_page.dart';
import 'package:flutter_app/scr/resources/Customer/hitory_page.dart';
import 'package:flutter_app/scr/resources/Customer/list_services_page.dart';
import 'package:flutter_app/scr/resources/Customer/list_store_page.dart';
import 'package:flutter_app/scr/resources/Customer/login_page.dart';
import 'package:flutter_app/scr/resources/Customer/main_menu_page.dart';
import 'package:flutter_app/scr/resources/Customer/options_page.dart';
import 'package:flutter_app/scr/resources/Customer/update_infor_page.dart';
import 'package:flutter_app/scr/resources/Customer/waiting_page.dart';
import 'package:flutter_app/scr/resources/Owner/add_services_page.dart';
import 'package:flutter_app/scr/resources/Owner/chat_screen.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/home_page_own.dart';
import 'package:flutter_app/scr/resources/Owner/list_chat_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/login_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/set_time_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page2.dart';
import 'package:flutter_app/scr/resources/Owner/waiting_own_page.dart';

class MyApp extends StatelessWidget{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      // HomePage()
      StreamBuilder<User>(
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && (!snapshot.data.isAnonymous)) {
            return HomePage();
          }
          return ChooseUser();
        },
      ),
    );
  }

}
