import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/network_util.dart';
import '../services/session_manager.dart';

mixin AppData {
  NetworkUtil networkUtil = NetworkUtil();
  SessionManager sessionManager = SessionManager();
}

class BaseRoute<T extends StatefulWidget> extends State<T> {
  AppLifecycleState? appState;

  @override
  void initState() {
    super.initState();
    appState = baseLifeCycle();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  AppLifecycleState? baseLifeCycle() {
    AppLifecycleState? appState;
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      switch (msg) {
        case "AppLifecycleState.paused":
          appState = AppLifecycleState.paused;
          break;
        case "AppLifecycleState.resumed":
          appState = AppLifecycleState.resumed;
          break;
        case "AppLifecycleState.inactive":
          appState = AppLifecycleState.inactive;
          break;
        default:
          return;
      }
      return null;
    });
    return appState;
  }

  double getMediaQueryHeight(BuildContext context, double px) {
    return MediaQuery.of(context).size.height * px;
  }

  double getMediaQueryWidth(BuildContext context, double px) {
    return MediaQuery.of(context).size.width * px;
  }
}
