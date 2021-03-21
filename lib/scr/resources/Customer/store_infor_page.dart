import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/Owner/chat_screen.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'file:///F:/DemoFlut/flutter_app/lib/scr/resources/Customer/choose_time_page.dart';

class DetailStore extends StatefulWidget {
  final String name,
      image,
      city,
      district,
      address,
      description,
      start,
      end,
      token,
      uid;

  DetailStore(this.name, this.image, this.city, this.district, this.address,
      this.description, this.start, this.end,this.token, this.uid);

  @override
  _DetailStoreState createState() => _DetailStoreState();
}

class _DetailStoreState extends State<DetailStore> {
  TextEditingController commentController = new TextEditingController();
  Query query;
  int like;
  String name, email, pass, address, phone, avatar, uid;

  bool commentStage = false;
  int commenta;
  String commentb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth auth = FirebaseAuth.instance;
    uid = auth.currentUser.uid;
    //truy xuat du lieu danh gia cua khach hang
    query = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(widget.uid)
        .child("Comment")
        .child("comment");
    //lay so luong like
    DatabaseReference reference2 = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(widget.uid)
        .child("Like");

    reference2.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          like = values["Count"];
        });
        print(widget.uid);
      });
    });
    //lay so luong commnent
    DatabaseReference referenceComment = FirebaseDatabase.instance
        .reference()
        .child("Stores")
        .child(widget.uid)
        .child("Comment");

    referenceComment.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, value) {
        setState(() {
          commenta = values["Count"];
          commentb = commenta.toString();
        });
        print(widget.uid);
      });
    });
    DatabaseReference comment =
        FirebaseDatabase.instance.reference().child("Users");
    comment.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key, values) {
        setState(() {
          email = auth.currentUser.email;
          name = values["name"];
          phone = values["phone"];
          pass = values["pass"];
          avatar = values["Image"];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFF383443),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              flexibleSpace: Container(
                height: 600,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(widget.image ??
                            "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/135634832_221471026121571_925480074581197249_o.jpg?_nc_cat=105&ccb=2&_nc_sid=b9115d&_nc_ohc=iZhweHX5XFwAX_qB48d&_nc_ht=scontent.fhan4-1.fna&oh=f4de4a1922e6e0570e7e136cfc62d2db&oe=601B77B2"),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: Text(
                          widget.name ?? " ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Text(widget.start + "-" + widget.end,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      widget.address +
                              "," +
                              widget.district +
                              "," +
                              widget.city ??
                          "",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Divider(
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: <Widget>[
                        LikeButton(
                          onTap: onLikeButtonTapped,
                          size: 30,
                          circleColor: CircleColor(
                              start: Color(0xff00ddff), end: Color(0xff0099cc)),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Color(0xff33b5e5),
                            dotSecondaryColor: Color(0xff0099cc),
                          ),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              // color: color,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 30,
                            );
                          },
                          likeCount: like ?? 0,
                          countBuilder: (int count, bool isLiked, String text) {
                            var color =
                                isLiked ? Colors.deepPurpleAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                "0",
                                style: TextStyle(color: color),
                              );
                            } else
                              result = Text(
                                text,
                                style: TextStyle(color: color),
                              );
                            return result;
                          },
                        ),
                        Text(
                          " Likes",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              commentStage = !commentStage;
                            });
                          },
                          icon: Icon(
                            Icons.message,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        Text(
                          commentb ?? "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        Text(" Comments",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            final action = CupertinoActionSheet(
                              title: Text(
                                "Chia sẻ",
                                style: TextStyle(fontSize: 30),
                              ),
                              message: Text(
                                "Chọn hình thức chia sẻ ",
                                style: TextStyle(fontSize: 15.0),
                              ),
                              actions: <Widget>[
                                CupertinoActionSheetAction(
                                  child: Text("Chia sẻ lên Facebook"),
                                  onPressed: () {
                                    FlutterShareMe().shareToFacebook(
                                      url:
                                          'https://github.com/hungcb21/Flutter_APP',
                                      msg: widget.name,
                                    );
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                ),
                                CupertinoActionSheetAction(
                                    child: Text("Chia sẻ lên Twitter"),
                                    onPressed: () async {
                                      var response = await FlutterShareMe()
                                          .shareToTwitter(
                                              url:
                                                  'https://github.com/hungcb21/Flutter_APP',
                                              msg: widget.name);
                                    }),
                                CupertinoActionSheetAction(
                                  child: Text("Khác"),
                                  // isDestructiveAction: true,
                                  onPressed: () async {
                                    var response = await FlutterShareMe()
                                        .shareToSystem(
                                            msg:
                                                'https://github.com/hungcb21/Flutter_APP');
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                )
                              ],
                              cancelButton: CupertinoActionSheetAction(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                              ),
                            );
                            showCupertinoModalPopup(
                                context: context, builder: (context) => action);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.share, color: Colors.white),
                              Text("  Share",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  !commentStage
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.description ?? "Khong co ",
                              style:
                                  TextStyle(color: Colors.white, height: 1.5),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                createButton(
                                    icon: Icon(
                                      Icons.book,
                                      color: Colors.white,
                                    ),
                                    color: Colors.blue,
                                    text: "BOOK NOW"),
                              ],
                            )
                          ],
                        )
                      : Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 250,
                                  child: FirebaseAnimatedList(
                                    query: query,
                                    itemBuilder: (BuildContext context,
                                        DataSnapshot snapshot,
                                        Animation<double> animation,
                                        int index) {
                                      return InkWell(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 30),
                                              margin:
                                                  EdgeInsets.only(bottom: 16),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 10),
                                                    blurRadius: 33,
                                                    color: Color(0xFFD3D3D3)
                                                        .withOpacity(.84),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(avatar ??
                                                              "https://scontent.fhan4-1.fna.fbcdn.net/v/t1.0-9/135634832_221471026121571_925480074581197249_o.jpg?_nc_cat=105&ccb=2&_nc_sid=b9115d&_nc_ohc=iZhweHX5XFwAX_qB48d&_nc_ht=scontent.fhan4-1.fna&oh=f4de4a1922e6e0570e7e136cfc62d2db&oe=601B77B2")),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 0, 0, 0),
                                                    child: Container(
                                                      width: 200,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            name ?? "",
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          new Text(
                                                            snapshot.value[
                                                                    "Comment"] ??
                                                                "",
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          labelText: "Comment",
                                          labelStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      onPressed: onCommentClick,
                                      color: Colors.blue,
                                      child: Text("Send"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.message),
            onPressed: () {
              onChatClicked();
            },
          ),
        ));
  }

  Widget createButton({icon, color, text}) {
    return ButtonTheme(
      minWidth: 200,
      height: 45,
      child: FlatButton.icon(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChooseTime(widget.uid, widget.name,
                      widget.address, widget.district, widget.city,widget.token)));
        },
        icon: icon,
        label: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    if (!isLiked) {
      like = like + 1;
      var ref = FirebaseDatabase.instance
          .reference()
          .child("Stores")
          .child(widget.uid);
      var likes = {"Count": like};
      ref.child("Like").update(likes);
    } else if (isLiked) {
      like = like - 1;
      var ref = FirebaseDatabase.instance
          .reference()
          .child("Stores")
          .child(widget.uid);

      var likes = {"Count": like};
      ref.child("Like").update(likes);
    }

    return !isLiked;
  }

  void onCommentClick() {
    if (commentController.text == "") {
      Fluttertoast.showToast(msg: "Vui lòng nhập bình luận");
    } else {
      commenta = commenta + 1;
      var ref2 = FirebaseDatabase.instance
          .reference()
          .child("Stores")
          .child(widget.uid);
      var count = {"Count": commenta};
      var ref3 = FirebaseDatabase.instance
          .reference()
          .child("Stores")
          .child(widget.uid);
      var category = {
        "Image": avatar,
        "Comment": commentController.text,
        "Name": name
      };
      ref2.child("Comment").child("comment").push().update(category);
      ref3.child("Comment").update(count);
      setState(() {
        commentb = commenta.toString();
      });
      commentController.text = "";
    }
  }

  void onChatClicked() {
    DatabaseReference refCreateRoom = FirebaseDatabase.instance.reference();
    DatabaseReference refCreateRoomOwn = FirebaseDatabase.instance.reference();
    DatabaseReference refCreateRoomCus = FirebaseDatabase.instance.reference();
    var uids = widget.uid + uid;
    refCreateRoom.child("Chat").child(uids).set({
      'cusUID': uid,
      'ownUID': widget.uid,
    });
    refCreateRoom.child("Chat").child(uids).child("Content").child("-MVttQrOfhZ09g_jfZS-").set({
      'text':
          "Chào mừng bạn đến với ${widget.name}, chúng tôi sẽ trả lời bạn sớm nhất",
      'uid': widget.uid,
      'senderName': widget.name,
      'senderPhotoUrl': widget.image
    }).then((value) {
      refCreateRoomCus.child("Users").child(uid).child("Chat").child(uids).set({
        'idRoomChat': uids,
        'lastMessenger': "",
        'storeImage': widget.image,
        'storeName': widget.name
      });
      refCreateRoomOwn
          .child("Stores")
          .child(widget.uid)
          .child("Chat")
          .child(uids)
          .set({
        'idRoomChat': uids,
        'lastMessenger': "",
        'cusImage': avatar,
        'cusName': name
      });
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChatScreen(uids,avatar,name)));
  }
}
