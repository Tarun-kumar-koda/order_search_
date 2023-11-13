import 'dart:async';

import 'package:get/get.dart';
import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/services/session_manager.dart';

import '../../base_route.dart';


class SplashScreenController extends GetxController with AppData {
  NetworkUtil networkUtil = NetworkUtil();
  var accessToken, refreshToken;
  var buttonLabel = Rxn<String>();
  String? routeStatus;
  String? routeId;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future getData() async {
    routeId = await sessionManager.getRouteId();
    accessToken = await sessionManager.getAccessToken();
    enterToApp();
  }


  Future<bool> isUserLoggedIn() async {
    if(await SessionManager().getInstance().getAccessToken() != ""){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> isRouteRunning() async {

    return false;
  }

  enterToApp() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, pageNavigator);
  }

  Future<void> pageNavigator() async {
    if (await isUserLoggedIn()) {
      Get.offAllNamed(AppLinks.searchOrderView);
      return;
    }else{
      Get.offAllNamed(AppLinks.loginNamedRoute);
      return;
    }
  }

}
