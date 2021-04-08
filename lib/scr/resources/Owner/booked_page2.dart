import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Class/TimeClass.dart';

class BookedPage extends StatefulWidget {
  @override
  _BookedPageState createState() => _BookedPageState();
}

class _BookedPageState extends State<BookedPage> {
  Query query;
  List<Time> datalist = [];
  int _selectedIndex = 0;
  FirebaseAuth firebaseUser = FirebaseAuth.instance;
  DataSnapshot dataSnapshot;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  String time;
  DateTime pickedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedDate = DateTime.now();
    var uid = firebaseUser.currentUser.uid;

    query = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(uid)
        .child("Waiting");
    DatabaseReference reference = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(uid)
        .child("Time")
        .child('time');
    reference.once().then((DataSnapshot dataSnapshot) {
      datalist.clear();
      var keys = dataSnapshot.value.keys;
      var values = dataSnapshot.value;
      // for(var key in keys)
      // {
      Time data = new Time(values["time"], values["status"]);
      datalist.add(data);
      // }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              child: Image.asset("images/left-arrow2.png"),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                child: Image.asset("images/magnifying-glass 1.png"),
              ),
            ),
          ],
          bottom: AppBar(
            backgroundColor: Colors.yellow,
            title: Text(
              "Booked",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
        ),
        body: Center(
          child: Container(
            color: Color(0xFF383443),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 1),
                  child: ListTile(
                    title: Text(
                      "${pickedDate.day},${pickedDate.month},${pickedDate.year}",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    ),
                    onTap: _pickDate,
                  ),
                ),
                Expanded(
                    child: new GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemCount: datalist.length,
                  itemBuilder: (_, index) {
                    //
                    // return CardUI(datalist[index].time,datalist[index].status,datalist);
                    return InkWell(
                      child: Card(
                          color:
                              _selectedIndex != null && _selectedIndex == index
                                  ? Colors.blue
                                  : Colors.white,
                          elevation: 10,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(datalist[index].time),
                                Text(datalist[index].status),
                              ],
                            ),
                          )),
                      onTap: () => setState(() {
                        _onSelected(index);
                        time = datalist[index].time;
                      }),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }
}
