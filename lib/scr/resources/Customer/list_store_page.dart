import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Class/StoreClass.dart';
import 'store_infor_page.dart';

class ListStore extends StatefulWidget {
  @override
  _ListStoreState createState() => _ListStoreState();
}

class _ListStoreState extends State<ListStore> {
  Query query;
  List<Store> listStoreFromDatabase = new List<Store>();
  List<Store> datalist = [];
  TextEditingController _searchController = new TextEditingController();
  bool searchState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    query = FirebaseDatabase.instance.reference().child('Stores');
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("Stores");
    // reference.once().then((DataSnapshot datasnapshot){
    //   datalist.clear();
    //   var keys = datasnapshot.value.keys;
    //   var values = datasnapshot.value;
    //   for(var key in keys)
    //     {
    //       Store data = new Store(
    //           values[key]["Image"],
    //           values[key]["NameStore"]
    //       );
    //       print(values[keys]);
    //      datalist.add(data);
    //     }
    //   setState(() {
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF383443),
        appBar: AppBar(
            backgroundColor: Color(0xFF383443),
            elevation: 0,
            title: !searchState
                ? Text("")
                : TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                            color: Colors.white)),
                    suggestionsCallback: (searchString) async {
                      return await searchComic(searchString);
                    },
                    itemBuilder: (context, comic) {
                      return ListTile(
                          leading: Image.network(comic.image),
                          title: Text("${comic.nameStore}"));
                    },
                    onSuggestionSelected: (comic) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailStore(
                                  comic.nameStore,
                                  comic.image,
                                  comic.city,
                                  comic.district,
                                  comic.address,
                                  comic.description,
                                  comic.timeStart,
                                  comic.timeEnd,
                                  comic.token,
                                  comic.key)));
                      setState(() {
                        datalist.clear();
                        searchState = !searchState;
                      });
                    }),
            actions: [
              !searchState
                  ? IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          datalist.clear();
                          searchState = !searchState;
                        });
                      },
                    )
                  : Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              searchState = !searchState;
                            });
                          },
                        ),
                      ],
                    ),
            ]),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Barbershop available",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        height: 600,
                        child: new FirebaseAnimatedList(
                            query: query,
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                index) {
                              Store data = new Store(
                                  snapshot.key,
                                  snapshot.value["Image"],
                                  snapshot.value["NameStore"],
                                  snapshot.value["Address"],
                                  snapshot.value["District"],
                                  snapshot.value["City"],
                                  snapshot.value["Description"],
                                  snapshot.value["TimeStart"],
                                  snapshot.value["TimeEnd"],
                                  snapshot.value["token"]);
                              datalist.add(data);
                              listStoreFromDatabase = datalist;
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailStore(
                                              snapshot.value["NameStore"],
                                              snapshot.value["Image"],
                                              snapshot.value["City"],
                                              snapshot.value["District"],
                                              snapshot.value["Address"],
                                              snapshot.value["Description"],
                                              snapshot.value["TimeStart"],
                                              snapshot.value["TimeEnd"],
                                              snapshot.value["token"],
                                              snapshot.key)));
                                },
                                child: Container(
                                  height: 120,
                                  color: Color(0xFF383443),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        snapshot.value["Image"] ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNK9yHOd59mG5Mq8YGD5l9xV-2MTXi2da9LA&usqp=CAU",
                                        height: 92,
                                        width: 200,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 200,
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                snapshot.value["NameStore"] ??
                                                    "",
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1
                                                    .copyWith(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                              )),
                                          Text("${snapshot.value["TimeStart"]}-${snapshot.value["TimeEnd"]}"??""
                                                ,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: SizedBox(
                                              width: 140,
                                              height: 30,
                                              child: RaisedButton(
                                                color: Colors.deepOrangeAccent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8))),
                                                onPressed: () {},
                                                child: Text(
                                                  "Booking",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
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

  Future<List<Store>> searchComic(String searchString) async {
    return listStoreFromDatabase
        .where((comic) =>
            comic.nameStore.toLowerCase().contains(searchString.toLowerCase()))
        .toList();
  }
}
