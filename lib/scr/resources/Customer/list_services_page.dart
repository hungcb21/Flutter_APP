import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/ServicesClass.dart';
import 'package:flutter_app/scr/resources/Customer/choose_time_page.dart';

import 'comfirm_page.dart';

class ListServices extends StatefulWidget {
  final String time,ten,address,district,city,day,storeUid,token;
  ListServices(this.time,this.ten,this.address,this.district,this.city,this.day,this.storeUid,this.token);
  @override
  _ListServicesState createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServices> {
  Query query;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool checkedValue = false;
  List<Services> datalist = [];
  List<bool> _isChecked;
  var uid;
  String name;
  int tong =0;
  double price;
  bool isEnabled = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // uid = auth.currentUser.uid;
    DatabaseReference reference;
    reference = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(widget.storeUid)
        .child("Services");

    reference.once().then((DataSnapshot dataSnapshot) {
      datalist.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for (var key in keys) {
        Services data = new Services(
            values[key]["NameServices"],
            values[key]["Price"]);
        datalist.add(data);
      }
      setState(() {
        _isChecked = List<bool>.filled(datalist.length, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 600,
                  child: ListView.builder(
                    itemCount: datalist.length,
                    itemBuilder: ( context,  index) {
                      return Container(
                        height: 100,
                        child: CheckboxListTile(
                            title: Text(
                              datalist[index].name,
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            subtitle: Text(
                             datalist[index].price.toString(),
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            value: _isChecked[index],

                            onChanged: (value) {
                              setState(() {
                                _isChecked[index] = value;
                                if(value==true)
                                  {
                                    DatabaseReference ref = FirebaseDatabase.instance.reference();
                                    var services = {"NameServices":datalist[index].name,"Price":datalist[index].price};
                                    ref.child("Stores")
                                        .child(widget.storeUid)
                                        .child("Customer").child("QKeOdvekxvPzxWVxbnK1UecTKdD2").child(datalist[index].name).set(services);
                                    tong = tong +datalist[index].price;
                                  }
                                else
                                  {
                                    DatabaseReference ref2= FirebaseDatabase.instance.reference();
                                    ref2.child("Stores")
                                        .child(widget.storeUid)
                                        .child("Customer").child("QKeOdvekxvPzxWVxbnK1UecTKdD2").child(datalist[index].name).remove();
                                    tong = tong -datalist[index].price;
                                  }

                                if(tong !=0){
                                  setState(() {
                                    isEnabled=true;
                                  });
                                }
                                else
                                  {
                                    setState(() {
                                      isEnabled=false;
                                    });
                                  }
                              });
                            }),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Tổng tiền: ${tong} VNĐ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: SizedBox(
                        width: 140,
                        height: 40,
                        child: RaisedButton(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                          onPressed:(){Navigator.pop(context);},
                          child: Text("Back",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      height: 40,
                      child: RaisedButton(
                        color: Colors.indigo,
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                        onPressed:isEnabled?()=>_onNextClicked():null,
                        child: Text("Next",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _onNextClicked(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Comfirm(widget.time,widget.ten,widget.address,widget.district,widget.city,widget.day,widget.storeUid,widget.token,tong)));
  }

}
