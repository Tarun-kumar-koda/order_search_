import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:order_search/routes/base_route.dart';

import '../../../Utils/utils.dart';
import '../../../constant/app_constant.dart';
import '../controller/login_screen_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseRoute<LoginView> {
  LoginController loginController = Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(children: [
            loginToolBar(),
            Container(
              color: Color(0xFFE0E0E0),
              width: getMediaQueryWidth(context, 1),
              height: 3,
            ),
            SizedBox(
              height: getMediaQueryHeight(context, 0.1),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: getMediaQueryWidth(context, 0.03),
                  right: getMediaQueryWidth(context, 0.03)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _countryCodeWidget(),
                  _textFieldWidget(),
                  _buttonWidget(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget loginToolBar() {
    return Container(
        padding: EdgeInsets.only(
            right: getMediaQueryWidth(context, 0.02),
            left: getMediaQueryWidth(context, 0.05)),
        margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.01)),
        height: getMediaQueryHeight(context, 0.055),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: getMediaQueryWidth(context, 0.10),
              width: getMediaQueryWidth(context, 0.35),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(AppConstant.splashScreenPath),
                ),
              ),
            ),
          ],
        ));
  }

  _countryCodeWidget() {
    return Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            SizedBox(
              width: getMediaQueryWidth(context, 0.4),
              child: CountryCodePicker(
                padding: EdgeInsets.zero,
                showOnlyCountryWhenClosed: false,
                alignLeft: true,
                onChanged: loginController.onCountryCodeChanged,
                initialSelection: 'US',
                countryFilter: ["IN", "US"],
                hideSearch: true,
                showDropDownButton: true,
                showFlagMain: false,
                // closeIcon: Icon(Icons.check),
                dialogTextStyle: TextStyle(fontSize: 12),
                // boxDecoration: BoxDecoration(shape: BoxShape.circle),
                textStyle: TextStyle(
                    fontSize: getMediaQueryWidth(context, 0.04),
                    color: Colors.black),
                dialogSize: Size(getMediaQueryWidth(context, 0.3),
                    getMediaQueryHeight(context, 0.2)),
              ),
            )
          ],
        ));
  }

  _textFieldWidget() {
    return Container(
      margin: EdgeInsets.only(
          top: getMediaQueryHeight(context, 0.02),
          left: getMediaQueryWidth(context, 0.035),
          right: getMediaQueryWidth(context, 0.035)),
      child: Form(
        key: loginController.numberTextFieldKey,
        child: TextFormField(
            cursorColor: Colors.black,
            controller: loginController.numberTextFieldController,
            validator: (String? value) => loginController.validatePhone(value!),
            autofocus: false,
            maxLines: 1,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
              LengthLimitingTextInputFormatter(10),
            ],
            style: TextStyle(
                color: Colors.black,
                fontSize: getMediaQueryWidth(context, 0.041)),
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              hintStyle: TextStyle(color: Colors.grey),
              hintText: AppConstant.mobileNumberText,
              contentPadding: EdgeInsets.all(16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            )),
      ),
    );
  }

  _buttonWidget() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          top: getMediaQueryHeight(context, 0.02),
          left: getMediaQueryWidth(context, 0.035),
          right: getMediaQueryWidth(context, 0.035)),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Utils.hexColor(AppColor.appPrimaryColor))),
          onPressed: () async {
            if (loginController.numberTextFieldKey.currentState!.validate()) {
              Utils.checkNetworkStatus().then((value) async {
                if (value) {
                  loginController.generateOtpHandler();
                } else {
                  Utils.showAlertDialog(AppConstant.networkNotConnected);
                }
              });
            }
          },
          child: loginController.commonWidgets
              .solidButton(context, AppConstant.temporaryPassword)),
    );
  }
}
