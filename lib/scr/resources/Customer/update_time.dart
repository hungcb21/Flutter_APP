import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/TimeClass.dart';
class UpdateTime extends StatefulWidget {
  String uid;
  UpdateTime(this.uid);
  @override
  _UpdateTimeState createState() => _UpdateTimeState();
}

class _UpdateTimeState extends State<UpdateTime> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var uid;
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
    uid = auth.currentUser.uid;
    pickedDate= DateTime.now();
    query= FirebaseDatabase.instance.reference().child("Stores").child(widget.uid).child("Waiting");
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Stores").child(widget.uid).child("Time");
    reference.once().then((DataSnapshot dataSnapshot){
      datalist.clear();
      var keys= dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      for(var key in keys)
      {
        Time data=new Time(
            values[key]["time"],
            values[key]["status"]
        );
        datalist.add(data);
        datalist.sort((a,b)=>a.time.compareTo(b.time));
      }
      setState(() {

      });
    });
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                        stream: FirebaseDatabase.instance.reference().child("Stores").child(widget.uid).child("Time").onValue,
                        builder: (BuildContext context,AsyncSnapshot<Event> snapshot) {
                          if (snapshot.hasData) {
                            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                            map.forEach((dynamic, v) => print(""));
                            List<dynamic> list = map.values.toList()..sort(
                                    (a, b) => a['time'].compareTo(b['time']));
                            return GridView.builder(
                              shrinkWrap: false,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                              itemCount: map.values
                                  .toList()
                                  .length,
                              itemBuilder:
                                  (BuildContext context,int index){
                                return InkWell(
                                  child: Container(
                                      color: _selectedIndex != null && _selectedIndex == index
                                          ? Colors.blue
                                          : Colors.white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:<Widget>[
                                            Text(list[index]["time"]),
                                          ],
                                        ),
                                      )
                                  ),
                                  onTap: ()=>setState(() {
                                    _onSelected(index);
                                    time=list[index]["time"];
                                    isEnabled=true;
                                  }),);
                              },
                            );
                          }
                          else if(snapshot.hasError){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else{
                            return Center(
                              child: Text("No data",style: TextStyle(fontSize: 20),),
                            );
                          }
                        })
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
                          child: Text("Ok",style: TextStyle(color: Colors.white),),
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
    DatabaseReference reference = FirebaseDatabase.instance.reference();
    reference.child("Stores").child(widget.uid).child("Waiting").child(uid).update({'Time':time});
    reference.child("Users").child(uid).child("Waiting").child(widget.uid).update({'Time':time});
    Navigator.pop(context);
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
