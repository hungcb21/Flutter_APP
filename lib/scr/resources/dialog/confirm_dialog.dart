import 'package:flutter/material.dart';
class ConfirmDialog{
  static void showConfirmDialog(BuildContext context,String title,String msg)
  {
    showDialog(context: context,builder: (context1){
      Future.delayed(Duration(seconds: 5), () {
        Navigator.of(context1).pop(true);
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
      });
      return AlertDialog(
        actions: <Widget>[
          Center(
            child: Column(
              children: [
                Image.asset("images/Vector1.png"),
                Text("BOOKING SUCCESS",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                Text("Check your email or sms \n for a booking barbershop\n confirmation . we see you\n soon",style: TextStyle(fontSize: 23),),
                FlatButton(
                  child: Text("Ok"),
                  onPressed: (){
                    Navigator.of(context1).pop(true);
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 3);
                  },
                ),
                Text("Will automatically return to the\n homepage after 5 seconds",style: TextStyle(fontSize: 15),)
              ],
            ),
          ),

        ],
      );
    });
  }
}