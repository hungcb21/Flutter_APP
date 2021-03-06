import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scr/resources/dialog/confirm_dialog.dart';
import 'package:momo_vn/momo_vn.dart';
class Comfirm extends StatefulWidget {
  final String time,ten,address,district,city,day,storeUid,token;
  int price;
  Comfirm(this.time,this.ten,this.address,this.district,this.city,this.day,this.storeUid,this.token,this.price);
  @override
  _ComfirmState createState() => _ComfirmState();
}

class _ComfirmState extends State<Comfirm> {
  final String serverToken = '	AAAAE20gnpk:APA91bFWWMS8ocapsunPLjwB4i7xAfJ-VTW9Nq0YROTIudvwnGofqc5K8LWmRoy0YKQEaCTri3Ezrr65duFXx4feUKnqylt6X6M1892mAXcFeMZFYlCcUqV1kvsXolg6vobI_6HiJdVB';
  FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String name,email,sdt,tokenCus,imageCus;
  MomoVn _momoPay;
  PaymentResponse _momoPaymentResult;
  String _payment_status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userUID = _firebaseAuth.currentUser.uid;
    DatabaseReference user= FirebaseDatabase.instance.reference().child("Users");
    user.orderByKey().equalTo(userUID).once().then((DataSnapshot snapshot){
      Map<dynamic,dynamic> values = snapshot.value;
      values.forEach((key,values) {
        setState(() {
          name=values["name"];
          email=values["email"];
          sdt=values["phone"];
          imageCus=values["Image"];
          tokenCus=values["token"];
        });

      });
    });
    _momoPay = MomoVn();
    _momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, _handlePaymentError);
    initPlatformState();
  }
  Future<void> initPlatformState() async {
    if (!mounted) return;
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color:Color(0xFF383443) ,
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text("Thanks for choosing us",style: TextStyle(fontSize: 25,color: Colors.white),),
                ),
                Container(
                  color: Colors.white,
                  height: 400,
                  width: 300,
                  child: Column(
                    children: [
                      Text("Info your booking the barbershop",style: TextStyle(fontSize: 18),),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Icon(Icons.calendar_today_outlined,size: 30,),
                          ),
                          Text(widget.time+"-"+widget.day,style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Icon(Icons.store,size: 30,),
                          ),
                          Text(widget.ten,style: TextStyle(fontSize: 20),),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Icon(Icons.assistant_photo_rounded,size: 30,),
                          ),
                          Container(
                            width: 150,
                              child: Text(widget.address??"",style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 20))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Icon(Icons.phone,size: 30,),
                          ),
                          Text("0904-2070-62",style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Icon(Icons.where_to_vote_sharp,size: 30,),
                          ),
                          Text(widget.district+","+widget.city,style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Icon(Icons.money_off,size: 30,),
                          ),
                          Text("Tổng tiền: ${widget.price.toString()}",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    height: 105,
                    width: 295,
                    color: Colors.white,
                    child: Column(
                      children: [
                          Text("Note for barbershop",style: TextStyle(fontSize: 20)),
                        Expanded(
                          child: TextField(
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(labelText: "If you have any special needs, please note here..."),
                        )
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: SizedBox(
                        width: 140,
                        height: 40,
                        child: RaisedButton(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                          onPressed:(){
                            Navigator.pop(context);
                          },
                          child: Text("Back",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                      child: SizedBox(
                        width: 140,
                        height: 40,
                        child: RaisedButton(
                          color: Colors.indigo,
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8))),
                          onPressed:(){
                            _onCheckoutClick();
                          },
                          child: Text("Booking",style: TextStyle(color: Colors.white),),
                        ),
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

  _onCheckoutClick() async{
    MomoPaymentInfo options = MomoPaymentInfo(
      merchantname: widget.ten,
      appScheme: "momoiqa420180417",
      merchantcode: 'MOMOIQA420180417',
      amount: double.parse(widget.price.toString()),
      orderId: '12321312',
      orderLabel: 'Gói dịch vụ ABCD',
      merchantnamelabel: "TRUNG TÂM XYZ",
      fee: 0,
      description: 'Thanh toán đặt chỗ',
      username: '0919100010',
      partner: 'MOMOIQA420180417',
      extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
      isTestMode: true,

    );
    try {
      _momoPay.open(options);
    } catch (e) {
      debugPrint(e);
    }

  }
  _onConfirmClick(){
    String userUID = _firebaseAuth.currentUser.uid;
    Map<String,String> waiting ={
      'NameCustomer':name,
      'EmailCustomer':email,
      'PhoneCustomer':sdt,
      'ImageCus':imageCus,
      'Day':widget.day,
      'Address':widget.address+","+widget.district+","+widget.city,
      'Time':widget.time,
      'tokenCus':tokenCus
    };
    Map<String,String> waitingCustomer ={
      'Time':widget.time,
      'Date':widget.day,
      'NameStore':widget.ten,
      'Address':widget.address,
      'District':widget.district,
      'City':widget.city,
      'token':widget.token,
    };
    ref.child("Stores").child(widget.storeUid).child("Waiting").child(userUID).set(waiting);
    ref.child("Users").child(userUID).child("Waiting").child(widget.storeUid).set(waitingCustomer).then((value){
    sendAndRetrieveMessage();
    ConfirmDialog.showConfirmDialog(context, "", "");
    });


  }
  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Thời gian: ${widget.time}, ngày: ${widget.day}',
            'title': 'Bạn nhận được một đề nghị đặt chỗ từ $name'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': await widget.token,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
    Completer<Map<String, dynamic>>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );
    return completer.future;
  }
  @override
  void dispose() {
    super.dispose();
    _momoPay.clear();
  }

  void _setState() {
    _payment_status = 'Đã chuyển thanh toán';
    if (_momoPaymentResult.isSuccess) {
      _payment_status += "\nTình trạng: Thành công.";
      _payment_status += "\nSố điện thoại: " + _momoPaymentResult.phonenumber;
      _payment_status += "\nExtra: " + _momoPaymentResult.extra;
      _payment_status += "\nToken: " + _momoPaymentResult.token;
      _onConfirmClick();
    }
    else {
      _payment_status += "\nTình trạng: Thất bại.";
      _payment_status += "\nExtra: " + _momoPaymentResult.extra;
      _payment_status += "\nMã lỗi: " + _momoPaymentResult.status.toString();
    }
  }
  void _handlePaymentSuccess(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THÀNH CÔNG: " + response.phonenumber);
  }

  void _handlePaymentError(PaymentResponse response) {
    setState(() {
      _momoPaymentResult = response;
      _setState();
    });
    Fluttertoast.showToast(msg: "THẤT BẠI: " + response.message.toString());
  }

}
