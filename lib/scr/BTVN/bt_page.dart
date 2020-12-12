import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BTVN extends StatefulWidget {
  @override
  _BTVNState createState() => _BTVNState();
}

class _BTVNState extends State<BTVN> {
  bool isCollased =true;
  double scrHeight,scrWidth;
  String text = "alo123";
  final Duration duration = const Duration(milliseconds: 300);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    scrHeight=size.height;
    scrWidth=size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
      ),
      drawer: Drawer(
        child: menu(context),
      ),

        body: Column(
          children:<Widget> [
            Text(text),
          ],
        ),
          

    );
  }
  Widget menu(context){
    return Container(
      child: Align(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: CircleAvatar(
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    setState((){
                      text ="Yatirimlar";
                      isCollased = !isCollased;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.wb_incandescent_outlined),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("Yatirimlar",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    setState((){
                      text ="Krediler";
                      isCollased = !isCollased;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.expand),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("Krediler",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    setState((){
                      text ="Kampanyalar";
                      isCollased = !isCollased;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.baby_changing_station_rounded),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("Kampanyalar",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 100),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    setState((){
                      text ="ATM/Sube Buculu";
                      isCollased = !isCollased;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.wb_incandescent_outlined),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("ATM/Sube Buculu",style: TextStyle(fontSize: 18),),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cikis Yap",style: TextStyle(color: Colors.green),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                child: Column(
                  children: [
                    Text("Bizimle Iletisime Gecin",style: TextStyle(color: Colors.green),),
                    Row(
                      children: [
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.headset_mic,
                            size: 35.0,
                            color: Colors.green,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.message,
                            size: 35.0,
                            color: Colors.green,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                        RawMaterialButton(
                          onPressed: () {},
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.mail,
                            size: 35.0,
                            color: Colors.green,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}


