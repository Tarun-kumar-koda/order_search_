import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/routes/base_route.dart';

import 'toolbar_controller.dart';

class ToolBarView extends StatefulWidget {
  const ToolBarView({super.key});

  @override
  State<ToolBarView> createState() => _ToolBarViewState();
}

class _ToolBarViewState extends BaseRoute<ToolBarView> with AppData, SingleTickerProviderStateMixin {
  ToolBarController toolBarController = Get.put(ToolBarController());

  Color iconColor = Colors.white70;

  bool dis = false;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _animationController.repeat(reverse: true, max: 1, min: 0.2);
    initListener();
    super.initState();
  }

  initListener() {
    toolBarController.changes.listen((p0) {
      setState(() {});
    });
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
    double spaceBetween = Get.currentRoute != AppLinks.stopListNamedRoute ? getMediaQueryWidth(context, 0.11) : getMediaQueryWidth(context, 0.13);
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
            // border: Border.all(color: Colors.grey.shade400, width: 2, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignOutside),
            borderRadius: BorderRadius.circular(40),
        ),
        margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.015), bottom: getMediaQueryHeight(context, 0.01)),
        height: getMediaQueryHeight(context, 0.07),
        width: getMediaQueryWidth(context, 0.98),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.15)),
            padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.025), vertical: getMediaQueryWidth(context, 0.01)),
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
                Row(children: [
                  toolBarController.pictures.value.length > 0
                      ? Container(
                    padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.03), vertical: getMediaQueryWidth(context, 0.01)),
                    decoration:
                    BoxDecoration(color: Colors.white24, border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Text("${toolBarController.pictures.value.length}",
                            style: TextStyle(fontSize: getMediaQueryWidth(context, 0.028), color: Colors.white, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: getMediaQueryWidth(context, 0.015),
                        ),
                        FadeTransition(
                          opacity: _animationController,
                          child: Text("Syncing...",
                              style: TextStyle(fontSize: getMediaQueryWidth(context, 0.028), color: Colors.white, fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                  )
                      : const Tooltip(
                    message: "All pictures are synced",
                    triggerMode: TooltipTriggerMode.tap,
                    child: Icon(
                      Icons.check_circle_outlined,
                      color: Colors.white,
                      fill: 1,
                      opticalSize: 1,
                    ),
                  ),
                  SizedBox(width: getMediaQueryWidth(context, 0.04),),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppLinks.profileNamedRoute);
                    },
                    child: Container(
                      // margin: EdgeInsets.only(left: getMediaQueryWidth(context, 0.03)),
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
                  )
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 64faf56dae83bf593d1db1a1
