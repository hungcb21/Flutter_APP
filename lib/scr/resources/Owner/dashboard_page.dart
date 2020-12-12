import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/booked_page.dart';
import 'package:flutter_app/scr/resources/Owner/history_own_page.dart';
import 'package:flutter_app/scr/resources/Owner/status_page.dart';
import 'package:flutter_app/scr/resources/Owner/upload_store_page.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text("Dashboard",style: TextStyle(fontSize: 30,color: Colors.black),),
        ),
        body: Container(
          color: Color(0xFF383443),
          child: GridView(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: [
              InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>UploadStore()));},
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/undraw_completed_tasks_vs6q 1.png"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text("Upload store",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>HistoryOwn()));},
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/undraw_Booked_re_vtod 1.png"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text("Booked",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context)=>Status()));},
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/undraw_new_notifications_fhvw 1.png"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text("Status",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("images/undraw_personal_info_0okl 1.png"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("News",style: TextStyle(fontSize: 18),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
