import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/login_own_page.dart';

import 'login_page.dart';
class ChooseUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFF383443),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("BẠN LÀ:",style: TextStyle(color: Colors.white,fontSize: 40),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginOwn()));
                    },
                    child: Container(
                      color: Colors.white,
                      width: 300,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/hairstyle 1.png"),
                          Text("Owner",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Container(
                      color: Colors.white,
                      width: 300,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_circle,size: 150,color: Colors.blue,),
                          Text("Customer",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
