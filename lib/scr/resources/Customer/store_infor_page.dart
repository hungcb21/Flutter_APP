import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/StoreClass.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/choose_time_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/main_menu_page.dart';

import 'Tam.dart';
class DetailStore extends StatelessWidget {
  final int index;
  final String name,image,city,district,address,description,uid;
  DetailStore(this.index,this.name,this.image,this.city,this.district,this.address,this.description,this.uid);
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF383443),
          leading:  InkWell(
            onTap: () {Navigator.pop(context);},
            child: Container(
              child: Image.asset("images/left-arrow2.png"),
            ),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
            color: Color(0xFF383443),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 600,
                            width: 300,
                            // color: Colors.white,
                            decoration: BoxDecoration(shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,),
                            child: Column(
                              children: [
                                Container(
                                  height: 206,
                                  width: 150,
                                  decoration: BoxDecoration(shape: BoxShape.circle,
                                      color: Colors.orange,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,image: NetworkImage(image)
                                      )),
                                ),
                                Text(name,style: TextStyle(fontSize: 25),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on_rounded),
                                    Text(city)
                                  ],
                                ),
                                Container(
                                  height: 200,
                                  width: 250,
                                  child: Text(description??"chua co"),
                                ),
                                SizedBox(
                                  width: 157,
                                  height: 51,
                                  child: RaisedButton(
                                    color: Colors.yellow,
                                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(30))),
                                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseTime(uid,name,address,district,city)));},
                                    child: Text("BOOK NOW",style: TextStyle(color: Colors.black,fontSize: 15),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          )
      ),
    );
  }
}
