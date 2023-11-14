import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:order_search/application_properties/app_enums.dart';
import 'package:order_search/application_properties/app_manager.dart';
import 'package:order_search/model/global_search_order.dart';
import 'package:order_search/my_app.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/services/database_helper.dart';
import 'package:order_search/services/offlinehelper.dart';
import 'package:realm/src/list.dart';

import 'services/session_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Env.setEnv(ENV_CONSTANTS.PROD);
  SharedPrefs().init();
  print("main");
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  DatabaseHelper();
  OfflineHelper().init();
  runApp(MyApp());

  // DatabaseHelper db = DatabaseHelper();
  // db.realm.write(() {
  //   db.realm.deleteAll<PicturesQueue>();
  //   db.realm.deleteAll<OrderPicture>();
  // });
  // StreamSubscription<RealmListChanges<OrderPicture>> listen = DatabaseHelper().realm.all<PicturesQueue>().first.queue.changes.listen((event) {
  //   print("&&&${event}");
  // });
  //
  // listen.onData((data) {
  //   print(data.list);
  // });
}