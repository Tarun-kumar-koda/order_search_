import 'dart:developer' as dev;

class Logger{
  static logMessenger({
    required String msgTitle,
    Map msgBody = const {},
    Map errorMsg = const {}
  }){
    dev.log("$msgBody", name: msgTitle, error: errorMsg == const {} ? null : errorMsg,time: DateTime.now());
  }
}
