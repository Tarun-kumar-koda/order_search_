import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/routes/splash_screen/controller/splash_screen_controller.dart';

import '../../base_route.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends BaseRoute<SplashScreenView> {

  SplashScreenController screenController = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: screenController.isUserLoggedIn(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            constraints: BoxConstraints.expand(),
            child: Container(
              child: Container(
                padding: EdgeInsets.only(
                    left: getMediaQueryWidth(context, 0.07),
                    right: getMediaQueryWidth(context, 0.07)),
                child: Image.asset(AppConstant.splashScreenPath,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
