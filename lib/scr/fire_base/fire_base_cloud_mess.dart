import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationSevices{
  final FirebaseMessaging _messaging = FirebaseMessaging();
  Future initialise() async{
    if(Platform.isIOS)
    {
      _messaging.requestNotificationPermissions(IosNotificationSettings());
    }
    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
    },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },

    );
  }

}