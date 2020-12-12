import 'package:flutter/material.dart';
import 'package:flutter_app/scr/app.dart';
import 'package:flutter_app/scr/fire_base/fire_base-auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
runApp(MyApp());
}

