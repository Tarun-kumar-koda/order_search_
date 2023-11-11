import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:order_search/Utils/logger.dart';
import 'package:order_search/model/user_model.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_constant.dart';

mixin RealmServices {
  Realm realm = Realm(Configuration.local([
    OrderPicture.schema
  ], schemaVersion:3));
}

class SharedPrefs {
  // The static property `_sharedPrefs` will hold a reference to the
  // `SharedPreferences` instance.
  static SharedPreferences? sharedPrefs;

  // The factory constructor is used to create a  instance of the class.
  factory SharedPrefs() => SharedPrefs._();

  // The private constructor is used to initialize the class.
  SharedPrefs._();

  // The `init()` method is used to initialize the `SharedPreferences`
  // instance.
  Future<void> init() async {
    sharedPrefs ??= await SharedPreferences.getInstance();
  }
}

class SessionManager with RealmServices{
  final String accessToken = "access_token";
  final String refreshToken = "refresh_token";
  final String userModel = "user_model";
  final String mobileNumber = "mobile_number";
  final String isUserSignIn = "is_sign_in";
  final String orgId = "org_id";
  final String userId = "user_id";
  final String currentRunningRouteId = "current_running_route_id";
  final String routeName = "Current_running_routeName";
  final String filterHint = "filter_name";
  final String exceptionData = "exception_data";
  final String filterList = "filters_list";

  late SessionManager sessionManager;
  late SharedPreferences _preferences;


  SessionManager getInstance() {
    sessionManager = SessionManager();
    return sessionManager;
  }

  Future<SharedPreferences> get preferences async {
    _preferences = await SharedPrefs.sharedPrefs ?? await SharedPreferences.getInstance();
    return _preferences;
  }

  Future<String> getAccessToken() async {
    final pref = await preferences;
    String accessToken = pref.getString(this.accessToken) ?? "";
    return accessToken;
  }

  Future<void> setAccessToken(String accessToken) async {
    final pref = await preferences;
    pref.setString(this.accessToken, accessToken);
    print(accessToken);
  }

  Future<String> getRefreshToken() async {
    final pref = await preferences;
    String refreshToken = pref.getString(this.refreshToken) ?? "";
    print(refreshToken);
    return refreshToken;
  }

  Future<void> setRefreshToken(String refreshToken) async {
    final pref = await preferences;
    pref.setString(this.refreshToken, refreshToken);
  }

  getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(this.userModel) ?? "");
  }

  setUserDetails(UserModel userModel) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(this.userModel, json.encode(userModel));
  }

  Future<String> getMobileNumber() async {
    final pref = await preferences;
    String mobileNumber = pref.getString(this.mobileNumber) ?? "";
    return mobileNumber;
  }

  Future<void> setMobileNumber(String mobileNumber) async {
    final pref = await preferences;
    pref.setString(this.mobileNumber, mobileNumber);
  }

  Future<bool> getUserSignInStatus() async {
    final pref = await preferences;
    bool? isUserSignIn = pref.getBool(this.isUserSignIn);
    return isUserSignIn ?? false;
  }

  Future<void> setUserSignInStatus(bool isUserSignIn) async {
    final pref = await preferences;
    pref.setBool(this.isUserSignIn, isUserSignIn);
  }

  Future<String> getUserId() async {
    final pref = await preferences;
    String userId = pref.getString(this.userId) ?? "";
    return userId;
  }

  Future<void> setUserId(String userId) async {
    final pref = await preferences;
    pref.setString(this.userId, userId);
  }

  Future<List<String>> getOrgIds() async {
    final pref = await preferences;
    return pref.getStringList(this.orgId) ?? [];
  }

  Future<bool> setOrgIds(List<String> list) async {
    final pref = await preferences;
    return await pref.setStringList(this.orgId, list);
  }

  Future<String> getRouteId() async {
    final pref = await preferences;
    String? routeId = pref.getString(this.currentRunningRouteId) ?? "";
    return routeId;
  }

  Future<void> setRouteId(String routeId) async {
    final pref = await preferences;
    pref.setString(this.currentRunningRouteId, routeId);
  }

  Future<void> setRouteName(String route) async {
    final pref = await preferences;
    pref.setString(this.routeName, route);
  }

  ///gets routeName
  Future<String> getRouteName() async {
    final pref = await preferences;
    String? routeName = pref.getString(this.routeName) ?? "";
    return routeName;
  }

  Future<bool> setExceptionData(List<String> list) async {
    final pref = await preferences;
    return await pref.setStringList(this.exceptionData, list);
  }

  ///clears route details such as { currentRunningRoute } ,{ routeName }
  Future<bool> clearRouteDetails() async {
    final pref = await preferences;
    try {
      //clear routeId, routeName
      Logger.logMessenger(
        msgTitle: "SESSION MANAGER",
        msgBody: {
          " clearing route details ": ["currentRunningRouteId", "routeName"],
        },
      );
      await pref.remove(this.currentRunningRouteId);
      await pref.remove(this.routeName);
      return true;
    } catch (ex) {
      Logger.logMessenger(
          msgTitle: "sharedPreferences",
          msgBody: {"sharedPreferences": "clearRouteDetails caused error", "stack trace:": ex});
      print(ex);
      return false;
    }
  }

  ///clears all the data in shared preferences with login details route details and session details.
  Future<void> clearPreferences() async {
    final pref = await preferences;
    pref.clear();
  }

  ///delete database and routeData in shared preferences
  Future<bool> wipeRouteData() async  {
    try{
      Logger.logMessenger(msgTitle: "SESSION MANAGER", msgBody: {"wipeRouteData()": "clearing route details"});
      await clearRouteDetails();
      return true;
    }catch(ex){
      Logger.logMessenger(msgTitle: "wipeRouteData()",msgBody: {"status": "failed","exception":ex});
    }
    return false;
  }

  ///Deleted database, clears shared preferences, logs out of the app
  Future<bool> logOut() async {
    try {
      await clearPreferences();
      Get.offAllNamed(AppLinks.loginNamedRoute);
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}

class SessionDetails {
  static SessionManager sessionManager = SessionManager();

  late String accessToken;
  late String refreshToken;
  late Map<String, dynamic> userModel;
  late String mobileNumber;
  late bool isUserSignIn;
  late List<String> orgId;
  late String driverId;
  late String routeId;
  late String routeName;

  // late String exceptionData;

  SessionDetails({
    required this.accessToken,
    required this.refreshToken,
    required this.userModel,
    required this.mobileNumber,
    required this.isUserSignIn,
    required this.orgId,
    required this.driverId,
    required this.routeId,
    required this.routeName,
    // required this.exceptionData
  });

  static Future<SessionDetails> getSessionInfo() async {
    return SessionDetails(
      userModel: await sessionManager.getUserDetails(),
      accessToken: await sessionManager.getAccessToken(),
      refreshToken: await sessionManager.getRefreshToken(),
      mobileNumber: await sessionManager.getMobileNumber(),
      isUserSignIn: await sessionManager.getUserSignInStatus(),
      orgId: await sessionManager.getOrgIds(),
      driverId: await sessionManager.getUserId(),
      routeId: await sessionManager.getRouteId(),
      routeName: await sessionManager.getRouteName(),
      // exceptionData: await sessionManager.get,
    );
  }


}
