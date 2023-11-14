
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/constant/db_constant.dart';
import 'package:order_search/routes/base_route.dart';

import '../../Utils/logger.dart';
import '../../constant/route_constant.dart';
import '../../services/session_manager.dart';
import 'toolbar_controller.dart';

class ToolBarView extends StatefulWidget {
  @override
  _ToolBarViewState createState() => _ToolBarViewState();
}

class _ToolBarViewState extends BaseRoute<ToolBarView> with AppData, SingleTickerProviderStateMixin {
  ToolBarController toolBarController = Get.put(ToolBarController());

  Color iconColor = Colors.white70;

  bool dis = false;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return toolBar();
  }

  Widget toolBar() {
    double spaceBetween = Get.currentRoute != AppLinks.stopListNamedRoute
        ? getMediaQueryWidth(context, 0.11)
        : getMediaQueryWidth(context, 0.13);
    return Align(
      alignment: Alignment.center,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.indigo.shade400,
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0, 1],
                colors: [
                  Colors.indigo.shade300,
                  Colors.indigo.shade800,
                  // Utils.hexColor(AppColor.appPrimaryColor),
                ],
              ),
              border: Border.all(
                  color: Colors.grey.shade400,
                  width: 2,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignOutside),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                // BoxShadow(offset: Offset(6, 5), color: Colors.grey.withOpacity(0.25), blurRadius: 8, spreadRadius: 4),
              ]),
          margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.015), bottom: getMediaQueryHeight(context, 0.01)),
          height: getMediaQueryHeight(context, 0.07),
          width: getMediaQueryWidth(context, 0.98),
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.15)),
            padding: EdgeInsets.all(getMediaQueryWidth(context, 0.01)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: getMediaQueryWidth(context, 0.08),
                  width: getMediaQueryWidth(context, 0.35),
                  child: Image.asset(
                    AppConstant.splashScreenPath,
                    filterQuality: FilterQuality.high,
                    color: Colors.white.withOpacity(0.85),
                    width: 120,
                    height: 70,
                  ),
                ),
                Row(
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () {
                        Get.toNamed(AppLinks.profileNamedRoute);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: getMediaQueryWidth(context, 0.03)),
                        child: toolBarController.isImageLoaded.value
                            ? CircleAvatar(
                          radius: getMediaQueryWidth(context, 0.05),
                          backgroundImage: NetworkImage(toolBarController.imgUrl.value),
                        )
                            : Image.asset(
                          AppConstant.profileImage,
                          width: MediaQuery.of(context).size.width * 0.09,
                          height: MediaQuery.of(context).size.height * 0.09,
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

// 64faf56dae83bf593d1db1a1
