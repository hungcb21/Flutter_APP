import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/search_result_page.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/store_infor_page.dart';

import '../Class/StoreClass.dart';
class ListStore extends StatefulWidget {
  @override
  _ListStoreState createState() => _ListStoreState();
}

class _ListStoreState extends State<ListStore> {
  Query query;
  List<Store> datalist=[];
  TextEditingController _searchController = new TextEditingController();
  bool searchState = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query= FirebaseDatabase.instance.reference().child('Stores');
    DatabaseReference reference= FirebaseDatabase.instance.reference().child("Stores");
    reference.once().then((DataSnapshot datasnapshot){
      datalist.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      for(var key in keys)
        {
          Store data = new Store(
              values[key]["Image"],
              values[key]["NameStore"]
          );
          print(values[keys]);
         datalist.add(data);
        }
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF383443),
        appBar: AppBar(
          backgroundColor: Color(0xFF383443) ,
              elevation:0,
              title: !searchState?Text(""):TextField(
                controller: _searchController,
                decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white),
              ),
              ),
              actions: [
                !searchState?IconButton(icon: Icon(Icons.search),onPressed: (){
                  setState(() {
                    searchState = ! searchState;
                  });
                },):Row(
                  children: [
                    IconButton(icon: Icon(Icons.search),onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchResult(_searchController.text)));
                      setState(() {
                        searchState = ! searchState;

                      });
                    },),
                    IconButton(icon: Icon(Icons.cancel),onPressed: (){
                      setState(() {
                        searchState = !searchState;
                      });
                    },),
                  ],
                )
                ,
              ]
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      children: <Widget>[
                        Text("Barbershop available",style: TextStyle(fontSize: 25,color: Colors.white),),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            height: 600,
                            child: new FirebaseAnimatedList(
                                query: query,itemBuilder:(BuildContext context,
                                DataSnapshot snapshot,Animation<double> animation,int index){
                              return InkWell(
                                onTap: (){Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>DetailStore(index,snapshot.value["NameStore"],snapshot.value["Image"],snapshot.value["City"],
                                        snapshot.value["District"],snapshot.value["Address"],snapshot.value["Description"],snapshot.value["TimeStart"],snapshot.value["TimeEnd"]
                                    ,snapshot.key)));},
                                child: Container(
                                  height: 100,
                                  color: Color(0xFF383443) ,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(snapshot.value["Image"],height: 92,width: 200,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.value["NameStore"],style: TextStyle(fontSize: 20,color: Colors.white),),
                                          Text(snapshot.value["TimeStart"]+"-"+ snapshot.value["TimeEnd"],style: TextStyle(fontSize: 15,color: Colors.white),),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                            child: SizedBox(
                                              width: 140,
                                              height: 30,
                                              child: RaisedButton(
                                                color: Colors.deepOrangeAccent,
                                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                                                onPressed: (){},
                                                child: Text("Booking",style: TextStyle(color: Colors.white),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ),
        ),

      ),
    );
  }
  void SearchMethod(String text) {
    DatabaseReference searchRef = FirebaseDatabase.instance.reference().child("Stores");
    searchRef.once().then((DataSnapshot snapshot){
      datalist.clear();
      var keys = snapshot.value.keys;
      var values = snapshot.value;
      for(var key in keys){
        Store data = new Store(
            values[key]["Image"],
            values[key]["NameStore"]);
        if(data.nameStore.contains(text)){
          datalist.add(data);
        }
      }
    });
  }
  Widget ListUI(String image,String nameStore)
  {
    return Card(
        color: Color(0xFF383443) ,
        elevation: 30,
        child: Row(
          children: [
            Image.network(image,height: 92,width: 124,),
            Column(
              children: [
                Text(nameStore,style: TextStyle(fontSize: 20,color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: 140,
                    height: 30,
                    child: RaisedButton(
                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                      onPressed: (){},
                      child: Text("Booking",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );

  }
}
