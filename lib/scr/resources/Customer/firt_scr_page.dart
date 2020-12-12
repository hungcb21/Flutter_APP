import 'package:flutter/material.dart';
class FirstScr extends StatefulWidget {
  @override
  _FirstScrState createState() => _FirstScrState();
}

class _FirstScrState extends State<FirstScr> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color:Color(0xFF383443) ,
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Container(
                    width: 170,
                    height: 157,
                    child: new Image.asset("images/hairstyle 1.png"),),
                ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: new Image.asset("images/AWESOME.png"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: new Image.asset("images/Line 1.png"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: new Image.asset("images/Booking Barbershop.png"),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: new Image.asset("images/Line 2.png"),),
                        Container(
                          child: new Image.asset("images/baber-scissors 1.png"),),
                        Container(
                          child: new Image.asset("images/Line 2.png"),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: new Image.asset("images/BECOME THE REAL MAN.png"),),
                  ), Padding(
                    padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                    child: SizedBox(
                      width: 140,
                      height: 40,
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                        onPressed: (){},
                        child: Text("Get Started",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
