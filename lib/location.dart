import 'package:flutter_app/scr/fire_base/fire_base_cloud_mess.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(() => PushNotificationSevices());
}