import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/my_app.dart';
import 'package:toast/toast.dart';

import 'app_enums.dart';

class Utils {
  static MaterialColor primaryMaterial = const MaterialColor(
    0xFF0D5589,
    const <int, Color>{
      50: const Color(0xff607ad6),
      100: const Color(0xff607ad6),
      200: const Color(0xff607ad6),
      300: const Color(0xff607ad6),
      400: const Color(0xff607ad6),
      500: const Color(0xff607ad6),
      600: const Color(0xff607ad6),
      700: const Color(0xff607ad6),
      800: const Color(0xff607ad6),
      900: const Color(0xff607ad6),
    },
  );

  static bool isValidPhoneNumber(String em) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(em);
  }

  static Future<bool> checkNetworkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static hexColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static Future showToastMessage(String message,{BuildContext? context}) async {
    if(context == null) return;
    ToastContext().init(context);
    return Toast.show(message, duration: Toast.lengthLong, gravity:  Toast.bottom,);
  }

  static String getDateFromUtc(DateTime? date) {
    try {
      if (date != null) {
        var formatter = DateFormat('d MMM, y h:mm a');
        String formattedDate = formatter.format(date);
        return formattedDate;
      } else {
        return 'n/a';
      }
    } catch (ex) {
      print(ex);
    }
    return "";
  }


  static void showLoadingDialog({String? msg}) {
    // if (Get.isDialogOpen ?? false) return;
    // Get.defaultDialog(
    //   title: "",
    //   barrierDismissible: false,
    //   content: Container(
    //     // color: Colors.blue,
    //     width: double.infinity,
    //     padding: EdgeInsets.all(15),
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         SizedBox(
    //           width: 30,
    //           height: 30,
    //           child: CircularProgressIndicator(
    //             strokeWidth: 2,
    //             color: Utils.hexColor(AppColor.appPrimaryColor),
    //           ),
    //         ),
    //         SizedBox(
    //           width: 15,
    //         ),
    //         msg != null ? Flexible(
    //           child: msg.length > 20 ? Text( msg,
    //             style: TextStyle(
    //                 fontSize: MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.035),
    //           ) : Text( msg,
    //             style: TextStyle(
    //                 fontSize: MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.045),
    //           ),
    //         ) : Flexible(
    //           child: Text(
    //             "Loading...",
    //             overflow: TextOverflow.fade,
    //             maxLines: 1,
    //             softWrap: false,
    //             style: TextStyle(
    //                 fontSize: MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.045),
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    // );
    Get.dialog(
        useSafeArea: true,
        barrierDismissible: false,
        Dialog(
          child: WillPopScope(
            onWillPop: () async {
              // return false;
              return true;
            },
            child: Container(
              // color: Colors.blue,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Utils.hexColor(AppColor.appPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  msg != null
                      ? Flexible(
                          child: msg.length > 20
                              ? Text(msg,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width *
                                              0.035),
                            textAlign: TextAlign.center,)
                              : Text(msg,
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width *
                                              0.045),
                            textAlign: TextAlign.center,),
                        )
                      : Flexible(
                          child: Text(
                            "Loading...",
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.045),
                          ),
                        )
                ],
              ),
            ),
          ),
        ));
    // showDialog(
    //   context: MyApp.navigatorKey.currentState!.overlay!.context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //         child: Container(
    //       width: double.infinity,
    //       padding: EdgeInsets.all(15),
    //       child: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           SizedBox(
    //             width: 30,
    //             height: 30,
    //             child: CircularProgressIndicator(
    //               strokeWidth: 2,
    //               color: Utils.hexColor(AppColor.appPrimaryColor),
    //             ),
    //           ),
    //           SizedBox(
    //             width: 15,
    //           ),
    //           msg != null ? Flexible(
    //             child: msg.length > 20 ? Text( msg,
    //               style: TextStyle(
    //                   fontSize: MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.035),
    //             ) : Text( msg,
    //               style: TextStyle(
    //                   fontSize: MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.045),
    //             ),
    //           ) : Flexible(
    //             child: Text(
    //               "Loading...",
    //               overflow: TextOverflow.fade,
    //               maxLines: 1,
    //               softWrap: false,
    //               style: TextStyle(
    //                   fontSize: MediaQuery.of(MyApp.navigatorKey.currentState!.overlay!.context).size.width * 0.045),
    //             ),
    //           )
    //         ],
    //       ),
    //     ));
    //   },
    // );
  }

  static void hideLoadingDialog() {
    if(Get.isDialogOpen ?? false)
    // Get.back(result: MyApp.navigatorKey.currentState!.overlay!.context);
      Navigator.of(Get.overlayContext ?? MyApp.navigatorKey.currentState!.overlay!.context).pop();
  }

  static showAlertDialog(String message) async {
    if (MyApp.navigatorKey.currentState!.overlay!.context.isPortrait) {
      return await showDialog(
        builder: (context) => Container(
          width: double.infinity,
          child: AlertDialog(
            alignment: Alignment.center,
            iconPadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            icon: Icon(Icons.warning_amber_rounded),
            iconColor: Colors.orangeAccent,
            titlePadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.03,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Fleet Enable',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.042, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$message",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.040),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              )
            ],
          ),
        ),
        context: MyApp.navigatorKey.currentState!.overlay!.context,
      );
    } else {
      /// landscape mode
      return await showDialog(
        builder: (context) => Container(
          width: double.infinity,
          child: AlertDialog(
            alignment: Alignment.center,
            iconPadding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
            icon: Icon(Icons.warning_amber_rounded),
            iconColor: Colors.orangeAccent,
            titlePadding: EdgeInsets.only(
              // left: MediaQuery.of(context).size.width * 0.06,
              top: MediaQuery.of(context).size.height * 0.03,
              // right: MediaQuery.of(context).size.width * 0.02,
            ),
            // contentPadding: EdgeInsets.only(
            //   left: MediaQuery.of(context).size.width * 0.15,
            //   top: MediaQuery.of(context).size.width * 0.02,
            //   // right: MediaQuery.of(context).size.width * 0.04,
            // ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              'Fleet Enable',
              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.042, fontWeight: FontWeight.bold),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$message",
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.040),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // actionsPadding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              )
            ],
          ),
        ),
        context: MyApp.navigatorKey.currentState!.overlay!.context,
      );
    }
  }

  static Future<bool?> showConfirmDialog(String message) async {
    bool? isConfirm;

    await showDialog(
      builder: (context) => OrientationBuilder(builder: (context,Orientation orientation) {
        return orientation == Orientation.portrait
            ? Container(
          width: double.infinity,
          child: AlertDialog(
            alignment: Alignment.center,
            iconPadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            icon: Icon(Icons.warning_amber_rounded),
            iconColor: Colors.orangeAccent,
            titlePadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.03,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              textAlign: TextAlign.center,
              'Fleet Enable',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.042, fontWeight: FontWeight.bold),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    textAlign: TextAlign.center,
                    "$message",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.040),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  isConfirm = false;
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              ),
              TextButton(
                onPressed: () {
                  isConfirm = true;
                  Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
                ),
              )
            ],
          ),
        ) : Container(
          width: double.infinity,
          child: AlertDialog(
            alignment: Alignment.center,
            iconPadding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
            icon: Icon(Icons.warning_amber_rounded),
            iconColor: Colors.orangeAccent,
            titlePadding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(
              textAlign: TextAlign.center,
              'Fleet Enable',
              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.042, fontWeight: FontWeight.bold),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    textAlign: TextAlign.center,
                    "$message",
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.040),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  isConfirm = false;
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.035),
                ),
              ),
              TextButton(
                onPressed: () {
                  isConfirm = true;
                  Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.035),
                ),
              )
            ],
          ),
        );
      },),
      context: MyApp.navigatorKey.currentState!.overlay!.context,
    );

    return isConfirm;
  }

  static String getTextValue(String? text) {
    if (text != null && text != "" && text != " " && text != "null")
      return text;
    else
      return "N/A";
  }


  static Future changeOrientation(Orientations mode) async {
    switch (mode) {
      case Orientations.LANDSCAPE:
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        break;

      case Orientations.PORTRAIT:
       await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        break;
    }
  }

  static List<List<Object>>? objectPartition(List<Object>? objects, {int divisions = 10}) {
    if (objects != null) {
      List<Object> clone = []..addAll(objects);
      List<List<Object>> result = <List<Object>>[];
      while (clone.isNotEmpty) {
        result.add(clone.take(divisions).toList());
        try {
          clone.removeRange(0, divisions);
        } catch (ex) {
          clone.clear();
        }
      }
      return result;
    }
    return null;
  }

  static bool isEmpty(String? value) => (value == null || value == "" || value == " " || value.trim() == "");
}
