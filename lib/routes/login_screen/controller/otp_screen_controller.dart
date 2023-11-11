import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/model/authentication_response.dart';
import 'package:order_search/model/token_model.dart';
import 'package:order_search/model/user_authentication.dart';
import 'package:order_search/model/user_model.dart';
import 'package:order_search/services/session_manager.dart';

import '../../../Utils/logger.dart';

class OtpScreenController extends GetxController {
  NetworkUtil networkUtil = NetworkUtil();

  // var isTimeOut = false.obs;
  // var isBelow10Sec = false.obs;
  String mobileNo = '';
  String countryCode = '';

  // String signature = "{{ app signature }}";
  String otpNumber = '';

  // String defaultModule = '';
  // var start = 30.obs;
  SessionManager sessionManager = SessionManager().getInstance();

  TextEditingController pinCodeFieldController = TextEditingController();

  FocusNode pinCodeFieldFocusNode = FocusNode();

  String? userId;

  var isLoading = false.obs;


  @override
  void onInit() async {
    super.onInit();
    // await getDetails();
  }

  @override
  void onClose() {
    super.onClose();
    // timer.cancel();
  }

  // void startTimer() {
  //   const oneSec = const Duration(seconds: 0);
  //   timer =  Timer.periodic(
  //     oneSec,
  //         (timer){
  //           if (start < 1) {
  //             timer.cancel();
  //           } else {
  //             start = start - 1;
  //           }
  //         }
  //   );
  // }

  // Future<void> getDetails() async {
  //   userId = await sessionManager.getUserId();
  //   accessToken = await sessionManager.getAccessToken();
  // }

  // void getAllInCompleteRoute() async {
  //   // Utils.showLoadingDialog();
  //   try {
  //     var res = await networkUtil.getDio(
  //         ApiConstant.endPoint.NAVROUTES, "USER_ROUTES",
  //         body: <String, dynamic>{
  //           ApiConstant.param.DRIVER_ID: userId,
  //           ApiConstant.param.ROUTE_STATUS: RouteConstants.STATUS_IN_COMPLETE,
  //           ApiConstant.param.TIME_ZONE: DateTime.now().timeZoneName,
  //         },
  //         headers: ApiConstant().getHeaders(accessToken));
  //     if (res != null) {
  //       if (res.statusCode == 200) {
  //         NavRouteResponse baseResponse = NavRouteResponse.fromJson(res.data);
  //         if (baseResponse.navRoutes.length > 0) {
  //           incompleteRouteList.value = baseResponse.navRoutes;
  //           for (int i = 0; i < baseResponse.navRoutes.length; i++) {
  //             String? routeStatus = baseResponse.navRoutes[i].rStatus;
  //             if (routeStatus != AppConstant.assignedStatus && routeStatus != AppConstant.completedStatus) {
  //               getParticularRoute(baseResponse.navRoutes[i].id);
  //               // swipeButtonController.routeStart(baseResponse.navRoutes[i].id);
  //               break;
  //             }
  //           }
  //           Get.offAllNamed(NamedRoute.routeListNamedRoute);
  //         } else {
  //           Get.offAllNamed(NamedRoute.routeListNamedRoute);
  //         }
  //       } else if (res.statusCode == 401) {
  //         if(await sessionManager.tokenExpiryHandler()){
  //           this.getAllInCompleteRoute();
  //         }
  //       } else {
  //         if (res.data["error"] != null)
  //           Utils.showAlertDialog(res.data["error"]);
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   // Utils.hideLoadingDialog();
  // }
  //
  // void getParticularRoute(String? routeId) async {
  //   try {
  //     var res = await networkUtil.getDio(
  //         "${ApiConstant.endPoint.GET_ROUTE}/$routeId", "GET_ROUTE",
  //         body: <String, dynamic>{
  //           ApiConstant.param.ID: routeId,
  //         },
  //         headers: ApiConstant().getHeaders(accessToken)
  //     );
  //     if (res != null) {
  //       if (res.statusCode == 200) {
  //         await swipeButtonController.routeStart(routeId ?? "");
  //         /// otp -> to stopList
  //         Get.offAllNamed(NamedRoute.stopListNamedRoute,arguments: <String,dynamic>{"nav_route": null});
  //       } else if (res.statusCode == 401) {
  //         if(await sessionManager.tokenExpiryHandler())
  //           this.getParticularRoute(routeId);
  //       } else {
  //         if (res.data["error"] != null)
  //           Utils.showAlertDialog(res.data["error"]);
  //       }
  //     }
  //   } catch (e) {
  //     Utils.showAlertDialog(e.toString());
  //     print(e);
  //   }
  // }

  Future<bool> verifyOtp() async {
    if (otpNumber.length != 6) {
      Utils.showAlertDialog(AppConstant.enterValidSecurityCode);
    } else {
      var res;
      try {
        // Utils.showLoadingDialog();
        isLoading.value = true;
        res = await networkUtil.postDio(ApiConstant.endPoint.VERIFY_OTP, "VERIFY_OTP", body: <String, dynamic>{
          ApiConstant.param.CLIENT_ID: ApiConstant.clientId,
          ApiConstant.param.CLIENT_SECRET: ApiConstant.clientSecretKey,
          ApiConstant.param.MOBILE_NUMBER: "$countryCode$mobileNo",
          ApiConstant.param.OTP: otpNumber,
          ApiConstant.param.OS_VERSION: "",
          ApiConstant.param.OS_TYPE: "${Platform.operatingSystem}",
          ApiConstant.param.DEVICE_NAME: "",
          ApiConstant.param.DEVICE_TOKEN: "",
        });
        if (res?.statusCode == 200) {
          AuthenticationResponse authenticationResponse = AuthenticationResponse.fromJson(res?.data);
          await saveSessionData(authenticationResponse);
          if (await sessionManager.accessToken == "") {
            Logger.logMessenger(msgTitle: AppLinks.loginNamedRoute, msgBody: {"access token": await sessionManager.accessToken});
            throw Exception();
          }
          //Navigate to search screen
          Get.offAllNamed(AppLinks.routeListNamedRoute);
          // Utils.hideLoadingDialog();
          isLoading.value = false;
          return true;
        } else {
          pinCodeFieldController.clear();
          throw Exception();
        }
      } catch (e) {
        // Utils.hideLoadingDialog();
        isLoading.value = false;
        if (res?.data["error"] != null) await Utils.showAlertDialog(res?.data["error"]);
        else Utils.showToastMessage("Something went wrong");
        pinCodeFieldFocusNode.requestFocus();
        Logger.logMessenger(msgTitle: AppLinks.loginNamedRoute, msgBody: {"exception": "$e"});
        return false;
      }
    }
    // Utils.hideLoadingDialog();
    isLoading.value = false;
    return false;
  }

  Future<void> saveSessionData(AuthenticationResponse authenticationResponse) async {
    List<UserAuthentication> tokensList = authenticationResponse.userAuthentication!;
    if (tokensList.length > 0) {
      UserAuthentication authentication = tokensList[0];
      TokenModel tokenModel = authentication.tokenModel!;
      await sessionManager.setAccessToken("${tokenModel.tokenType!} ${tokenModel.accessToken!}");
      await sessionManager.setRefreshToken(tokenModel.refreshToken!);
      await sessionManager.setMobileNumber(mobileNo);
      await sessionManager.setUserId(tokenModel.userId!);
      UserModel user = authentication.userModel!;
      await sessionManager.setUserDetails(user);
      await sessionManager.setUserSignInStatus(user.isSignIn ?? false);
      if ((user.orgIds?.length ?? 0) > 0) await sessionManager.setOrgIds(user.orgIds ?? []);
    }
    return;
  }
}
