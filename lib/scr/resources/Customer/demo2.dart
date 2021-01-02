import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Class/DataDemo.dart';
import '../Class/TimeClass.dart';
class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}
class _Demo2State extends State<Demo2> {
  Query query;
  bool isEnabled = false ;
  List<Time> datalist=[];
  int _selectedIndex = 0;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }
  String time;
  DateTime pickedDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate= DateTime.now();
    query= FirebaseDatabase.instance.reference().child("Stores").child("W7tgDzOmELYOkuFddzDpZDi8DpE3").child("Waiting");
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Stores").child("W7tgDzOmELYOkuFddzDpZDi8DpE3").child("Time");
    reference.once().then((DataSnapshot dataSnapshot){
      datalist.clear();
      var keys= dataSnapshot.key;
      var values = dataSnapshot.value;


        Time data=new Time(
            values[dataSnapshot.key]["time"],
            values[keys]["status"]
        );
        datalist.add(data);

      setState(() {
      });
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        Center(
          child: Container(
            color:Color(0xFF383443) ,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 1),
                  child: ListTile(
                    title: Text("${pickedDate.day},${pickedDate.month},${pickedDate.year}",style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.arrow_downward,color: Colors.white,),
                    onTap: _pickDate,
                  ),
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseDatabase.instance.reference().child("Stores").child("W7tgDzOmELYOkuFddzDpZDi8DpE3").child("Time").onValue,
                        builder:  (BuildContext context,AsyncSnapshot snapshot){
                          if(snapshot.hasData)
                          {
                            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                            List<dynamic> list = map.values.toList()..sort((a, b) => a['time'].compareTo(b['time']));
                            return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                              itemCount: list.length,
                              itemBuilder:
                                  (context,index){
                                return InkWell(
                                  child: Container(
                                      color: _selectedIndex != null && _selectedIndex == index
                                          ? Colors.blue
                                          : Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:<Widget>[
                                            Text(list[index]['time'].toString()),
                                          ],
                                        ),
                                      )
                                  ),
                                  onTap: ()=>setState(() {
                                    _onSelected(index);
                                    time=list[index]['time'].toString();
                                    isEnabled=true;
                                  }),);
                              },
                            );
                          }
                        }
                    )
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: SizedBox(
                          width: 140,
                          height: 40,
                          child: RaisedButton(
                            color: Colors.blueAccent,
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
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                          onPressed:isEnabled?()=>_onNextClicked():null,
                          child: Text("Next",style: TextStyle(color: Colors.white),),
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
    );
  }
  _onNextClicked(){
  }
  _pickDate()
  async{
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: pickedDate,
    );
    if(date != null)
    {
      setState(() {
        pickedDate =date;
      });
    }
  }
}
Widget CardUI(String time,String status)
{
  return Card(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text(time),
            Text(status),
          ],
        ),
      )
  );

}
