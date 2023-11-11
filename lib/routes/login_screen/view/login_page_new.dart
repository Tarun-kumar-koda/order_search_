
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Utils/utils.dart';
import '../../../constant/app_constant.dart';
import '../../../widgets/login_page_wIdgets/slide_animtion.dart';
import '../../base_route.dart';
import '../controller/login_screen_controller.dart';
import '../controller/otp_screen_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseRoute<LoginPage> with SingleTickerProviderStateMixin {
  LoginController loginController = Get.put(LoginController(), permanent: true);

  late TabController _tabController;

  late RxInt curPage;

  RxBool showTextPadding = true.obs;

  late ScrollController verifyOtpScrollController;

  var keyBoard = KeyboardVisibilityController();

  OtpScreenController otpController = Get.put(OtpScreenController());

  @override
  void initState() {
    verifyOtpScrollController = ScrollController();
    curPage = 0.obs;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      print("calling _tabController listener");
      curPage.value = _tabController.index;
    });

    keyBoard.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if (verifyOtpScrollController.hasClients)
      verifyOtpScrollController.animateTo(getMediaQueryHeight(context, 0.05), duration: Duration(milliseconds: 400), curve: Curves.linear);
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    verifyOtpScrollController.dispose();
    super.dispose();
  }

  _goToTab(int index) {
    _tabController.animateTo(index);
  }

  // setFocusOn

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            SlideToast(imageWidget(), x: -0.2, y: -0.2),
            SizedBox(
              height: getMediaQueryHeight(context, 0.03),
            ),
            Flexible(
              child: SlideToast(loginContainer(), x: 0.1, y: 0.1),
            ),
            // Container(constraints:BoxConstraints(maxHeight:  MediaQuery.of(context).viewPadding.bottom))
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(getMediaQueryWidth(context, 0.15))),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                spreadRadius: 0.5,
                blurRadius: 90,
                offset: const Offset(0, 6),
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(getMediaQueryWidth(context, 0.15))),
          child: Image.asset(
            'assets/images/fleet_truck.png',
            // Replace with your image file path
            width: getMediaQueryWidth(context, 1.0),
            height: getMediaQueryHeight(context, 0.40),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter, // Adjust the fit as per your requirements
          ),
        ),
      ),
      Container(
        height: getMediaQueryHeight(context, 0.3),
        padding: const EdgeInsets.only(top: 40, left: 15),
        child: Obx(
          () => Text(
            curPage.value == 0 ? "Login" : "Enter OTP",
            style: const TextStyle(color: Colors.white60, fontSize: 30, fontWeight: FontWeight.w400),
          ),
        ),
      )
    ]);
  }

  Widget loginContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getMediaQueryWidth(context, 0.15),
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                enterNumberTab(),
                verifyOtpTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  enterNumberTab() {
    return AbsorbPointer(
      absorbing: loginController.isLoading.value,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: !keyBoard.isVisible,
                  child: SizedBox(
                    height: getMediaQueryWidth(context, 0.17),
                  ).animate().scale(duration: Duration(seconds: 1)),
                ),
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: keyBoard.isVisible,
                  child: SizedBox(
                    height: getMediaQueryWidth(context, 0.1),
                  ).animate().scale(duration: Duration(seconds: 1)),
                ),
                SizedBox(
                  width: getMediaQueryWidth(context, 1),
                  height: getMediaQueryHeight(context, 0.05),
                  child: CountryCodePicker(
                    onChanged: loginController.onCountryCodeChanged,
                    padding: EdgeInsets.only(left: getMediaQueryWidth(context, 0.04)),
                    showOnlyCountryWhenClosed: false,
                    showFlag: true,
                    alignLeft: true,
                    barrierColor: Colors.black38,
                    // closeIcon: Icon(),
                    flagWidth: 25,
                    showCountryOnly: true,
                    showDropDownButton: true,
                    // dialogBackgroundColor: Colors.transparent,
                    // onChanged: loginController.onCountryCodeChanged,
                    initialSelection: 'IN',
                    countryFilter: const ['IN', 'US'],
                    textStyle: TextStyle(fontSize: getMediaQueryWidth(context, 0.04), color: Colors.black),
                    dialogSize: Size(getMediaQueryWidth(context, 0.9), getMediaQueryHeight(context, 0.30)),
                    // dialogTextStyle: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: getMediaQueryWidth(context, 0.08), right: getMediaQueryWidth(context, 0.08)),
                  child: Form(
                    key: loginController.numberTextFieldKey,
                    child: TextFormField(
                      controller: loginController.numberTextFieldController,
                      cursorColor: Colors.black,
                      // controller: loginController.numberTextFieldController,
                      validator: (String? value) => loginController.validatePhone(value!),
                      autofocus: false,
                      maxLines: 1,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      // textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      style: TextStyle(color: Colors.black, fontSize: getMediaQueryWidth(context, 0.041)),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "enter mobile number",
                        // contentPadding: EdgeInsets.only(bottom: getMediaQueryWidth(context, 0.5)
                        // ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getMediaQueryHeight(context, 0.06),
                ),
                Obx(() => ElevatedButton(
                      style: ButtonStyle(
                          animationDuration: const Duration(milliseconds: 100),
                          // visualDensity: VisualDensity(vertical: 1,horizontal: 1),
                          elevation: const MaterialStatePropertyAll<double>(5),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                      onPressed: () async {
                        if (loginController.numberTextFieldKey.currentState!.validate() &&
                            !loginController.isLoading.value) {
                          Utils.checkNetworkStatus().then((value) async {
                            if (value) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (await loginController.generateOtpHandler()) {
                                setState(() {
                                  otpController.mobileNo = loginController.mobileNumber.value;
                                  otpController.countryCode = loginController.countryCode.value;
                                });
                                _goToTab(1);
                              }
                            } else {
                              Utils.showAlertDialog(AppConstant.networkNotConnected);
                            }
                          });
                        }
                      },
                      child: SizedBox(
                        child: loginController.isLoading.value
                            ? SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5))
                            : Text(
                                'Generate OTP',
                                style: TextStyle(fontSize: 17),
                              ),
                      ),
                    )),
              ],
            ),
          ),
          Obx(
            () => loginController.isLoading.value
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          getMediaQueryWidth(context, 0.15),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  verifyOtpTab() {
    return AbsorbPointer(
      absorbing: otpController.isLoading.value,
      child: Stack(
        children: [
          // loginController.isLoading.value ?
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: SingleChildScrollView(
              controller: verifyOtpScrollController,
              physics: BouncingScrollPhysics(),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: getMediaQueryHeight(context, 0.03),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: getMediaQueryWidth(context, 0.05)),
                    child: TextButton(
                        style: ButtonStyle(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                          animationDuration: Duration(milliseconds: 100),
                        ),
                        onPressed: () {
                          _goToTab(0);
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                    CupertinoIcons.chevron_left_circle,
                                    color: Colors.indigo,
                                    size: getMediaQueryHeight(context, 0.04),
                                  ),
                                  alignment: PlaceholderAlignment.middle),
                              const TextSpan(
                                text: " Back",
                                style: TextStyle(color: Colors.indigo),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: getMediaQueryHeight(context, 0.01),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 10, color: Colors.black87),
                    children: <TextSpan>[
                      TextSpan(
                          text: "Enter the OTP sent to ",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                          children: <TextSpan>[
                            TextSpan(
                                text: '"${loginController.countryCode.value} ${otpController.mobileNo}"',
                                style: TextStyle(fontWeight: FontWeight.w500))
                          ]),
                      // TextSpan(text: data.exceptionMessage,),
                    ],
                  ),
                ),
                SizedBox(
                  height: getMediaQueryHeight(context, 0.06),
                ),
                SizedBox(
                    width: getMediaQueryWidth(context, 0.75),
                    child: PinCodeTextField(
                      controller: otpController.pinCodeFieldController,
                      focusNode: otpController.pinCodeFieldFocusNode,
                      autoFocus: true,
                      autoUnfocus: true,
                      enablePinAutofill: true,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onChanged: (String value) {},
                      onCompleted: (otp) async {
                        otpController.otpNumber = otp;
                        await otpController.verifyOtp();
                      },
                      appContext: context,
                      length: 6,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.underline,
                          activeColor: Colors.grey,
                          inactiveColor: Colors.grey,
                          selectedColor: Utils.hexColor(AppColor.appPrimaryColor)),
                      textStyle: TextStyle(fontSize: getMediaQueryWidth(context, 0.045), fontWeight: FontWeight.normal),
                    )),
                SizedBox(height: getMediaQueryHeight(context, 0.02)),
                Obx(()=>
                    ElevatedButton(
                      style: ButtonStyle(
                          animationDuration: const Duration(milliseconds: 100),
                          // visualDensity: VisualDensity(vertical: 1,horizontal: 1),
                          elevation: const MaterialStatePropertyAll<double>(5),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                      onPressed: () async {
                        Utils.checkNetworkStatus().then((value) async {
                          if (value) {
                            // Utils.showLoadingDialog();
                            await otpController.verifyOtp();
                            // Utils.hideLoadingDialog();
                          } else {
                            Utils.showAlertDialog(AppConstant.networkNotConnected);
                          }
                        });
                      },
                      child: otpController.isLoading.value
                          ? SizedBox(width: 15,height: 15,child: CircularProgressIndicator(color: Colors.white, strokeWidth: 1.5))
                          : Text('Login',style: TextStyle(fontSize: 17)),
                    )
                ),
                TextButton(
                  onPressed: () {
                    loginController.generateOtpHandler();
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  ),
                  child: const Text(
                    'Re-send verification code',
                    style: TextStyle(
                      fontSize: 15,
                      // decoration: TextDecoration.underline,decorationThickness: 0.5,decorationColor: Colors.indigoAccent
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _goToTab(0);
                    },
                    style: ButtonStyle(
                      splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
                    ),
                    child: const Text('Re-enter mobile number', style: TextStyle(fontSize: 15)))
              ]),
            ),
          ),
          Obx(
                () => otpController.isLoading.value
                ? Container(
              decoration: BoxDecoration(
                color: Colors.white38,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    getMediaQueryWidth(context, 0.15),
                  ),
                ),
              ),
            )
                : Container(),
          ),
        ],
      ),
    );
  }
}
