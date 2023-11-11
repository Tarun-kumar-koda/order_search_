import 'dart:async';

import 'package:get/get.dart';
import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/constant/app_constant.dart';

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
    test();
  }

  test(){

  }

  Future getData() async {
    routeId = await sessionManager.getRouteId();
    accessToken = await sessionManager.getAccessToken();
    // enterToApp();
    pageNavigator();

    print(routeId);
    print(accessToken);
  }


  Future<bool> isUserLoggedIn() async {
    if(await sessionManager.getAccessToken() != "") return true;
      return false;
  }

  Future<bool> isRouteRunning() async {

    return false;
  }

  Future<void> pageNavigator() async {
    if (await isUserLoggedIn()) {
      Get.offAllNamed(AppLinks.searchOrderView);
      return;
    }
    Get.offAllNamed(AppLinks.loginNamedRoute);
  }

}
