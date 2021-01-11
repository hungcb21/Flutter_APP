import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Customer/store_infor_page.dart';
class SearchResult extends StatefulWidget {
  String uid;
  SearchResult(this.uid);
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  Query query;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query= FirebaseDatabase.instance.reference().child("Search").child(widget.uid);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: Icon(Icons.arrow_back),),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          color:Color(0xFF383443) ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FirebaseAnimatedList(shrinkWrap: true,
                    query: query,itemBuilder:(BuildContext context,
                        DataSnapshot snapshot,Animation<double> animation,int index){
                      return InkWell(
                        onTap: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>DetailStore(index,snapshot.value["NameStore"],snapshot.value["Image"],snapshot.value["City"],
                                snapshot.value["District"],snapshot.value["Address"],snapshot.value["TimeStart"],snapshot.value["TimeEnd"],snapshot.value["Description"]
                                ,snapshot.key)));},
                        child: Card(
                          color: Color(0xFF383443) ,
                          elevation: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.value["Image"])
                                  )
                                ),
                                height: 92,
                                width: 200,
                              ),
                              // Image.network(snapshot.value["Image"],height: 92,width: 200,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.value["NameStore"],style: TextStyle(fontSize: 20,color: Colors.white),),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
