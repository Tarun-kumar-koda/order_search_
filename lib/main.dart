import 'dart:io';

import 'package:flutter/material.dart';
import 'package:order_search/application_properties/app_enums.dart';
import 'package:order_search/application_properties/app_manager.dart';
import 'package:order_search/my_app.dart';

import 'services/session_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Env.setEnv(ENV_CONSTANTS.BETA);
  SharedPrefs().init();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(MyApp());
}