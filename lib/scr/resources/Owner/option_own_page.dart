import 'package:flutter/material.dart';
class OptionsOwn extends StatefulWidget {
  @override
  _OptionsOwnState createState() => _OptionsOwnState();
}

class _OptionsOwnState extends State<OptionsOwn> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Options", style: TextStyle(fontSize: 25, color: Colors.black),),
          backgroundColor: Colors.yellow,
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFF383443),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.update, size: 30,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text("Update"),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.arrow_forward, size: 30,)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.language, size: 30,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text("Language"),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.arrow_forward, size: 30,)),
                        ],
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.feedback, size: 30,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text("Feedback"),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.arrow_forward, size: 30,)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    height: 70,
                    width: 400,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.language, size: 30,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text("Language"),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {},
                              child: Icon(Icons.arrow_forward, size: 30,)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                  child: Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            height: 70,
                            width: 400,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.help, size: 30,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: Text("Help"),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.arrow_forward, size: 30,)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Image.asset("images/Line 53.png"),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Container(
                            height: 70,
                            width: 400,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.policy, size: 30,),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: Text("Policy"),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.arrow_forward, size: 30,)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
