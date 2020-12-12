import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/TimeClass.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/comfirm_page.dart';
class ChooseTime extends StatefulWidget {
  final String uid,name,address,district,city;
  ChooseTime(this.uid,this.name,this.address,this.district,this.city);
  @override
  _ChooseTimeState createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  Query query;
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
      }
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
                Text(widget.uid),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 1),
                  child: ListTile(
                    title: Text("${pickedDate.day},${pickedDate.month},${pickedDate.year}",style: TextStyle(color: Colors.white),),
                    trailing: Icon(Icons.arrow_downward,color: Colors.white,),
                    onTap: _pickDate,
                  ),
                ),
                Expanded(
                    child: new GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5),
                      itemCount: datalist.length,itemBuilder:
                        (_,index){

                      // return CardUI(datalist[index].time,datalist[index].status);
                     return InkWell(

                       child: Container(

                         color: _selectedIndex != null && _selectedIndex == index
                             ? Colors.blue
                             : Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:<Widget>[
                                Text(datalist[index].time),
                                Text(datalist[index].status),
                              ],
                            ),
                          )
                      ),
                       onTap: ()=>setState(() {
                         _onSelected(index);
                         time=datalist[index].time;
                       }),);
                    },
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
                          onPressed:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Comfirm(time,widget.name,widget.address,widget.district,widget.city,"${pickedDate.day}/${pickedDate.month}/${pickedDate.year}",widget.uid)));
                          },
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
