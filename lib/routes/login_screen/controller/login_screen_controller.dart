import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/routes/login_screen/model/login_model.dart';
import 'package:order_search/widgets/common_widgets.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginController extends GetxController {
  NetworkUtil networkUtil = NetworkUtil();
  final numberTextFieldController = TextEditingController();
  final commonWidgets = CommonWidgets();
  final numberTextFieldKey = GlobalKey<FormState>();
  var loginModel = LoginModel(countryCode: "", mobileName: "").obs;
  var isLoading = false.obs;
  var mobileNumber = "".obs;
  var countryCode = "+91".obs;
  var signature = "";

  @override
  void onInit() {
    super.onInit();
    numberTextFieldController.text = mobileNumber.value;
    if (Platform.isAndroid)
      SmsAutoFill().getAppSignature.then((value) => {signature = value});
  }

  onCountryCodeChanged(CountryCode code) {
    countryCode.value = code.dialCode!;
  }

  validatePhone(String text) {
    mobileNumber.value = text;
    if (text.isEmpty) {
      return AppConstant.emptyMobileNumber;
    } else if (!Utils.isValidPhoneNumber(text)) {
      return AppConstant.inValidMobileNumber;
    }
  }

  void convertWholeClassObsToUpper() {
    loginModel.update((val) {
      val!.mobileName = val.mobileName.toString().toUpperCase();
    });
  }

  Future<bool> generateOtpHandler() async {
    // Utils.showLoadingDialog();
    isLoading.value = true;
    try {
      var res = await networkUtil.postDio(
          ApiConstant.endPoint.SEND_OTP, "SEND_OTP",
          body: <String, dynamic>{
            ApiConstant.param.CLIENT_ID: ApiConstant.clientId,
            ApiConstant.param.CLIENT_SECRET: ApiConstant.clientSecretKey,
            ApiConstant.param.MOBILE_NUMBER:
                "${countryCode.value}${mobileNumber.value}",
            ApiConstant.param.MESSAGE_ID: signature,
          });
      print(res?.statusCode);
      isLoading.value = false;
      // Utils.hideLoadingDialog();
      if (res != null) {
        if (res.statusCode == 200) {
          Utils.showToastMessage("Otp message has been sent to ${countryCode.value} ${mobileNumber.value}");
          return true;
        } else {
          if (res.data["error"] != null) {
            Utils.showAlertDialog(res.data["error"]);
          };
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
