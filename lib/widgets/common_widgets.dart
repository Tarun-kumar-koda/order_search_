import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/routes/base_route.dart';

import '../Utils/utils.dart';
import '../constant/app_constant.dart';

class CommonWidgets {
  Widget solidButton(BuildContext context, String buttonName) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.012, bottom: MediaQuery.of(context).size.height * 0.012),
      child: Text(buttonName,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

class ExpandableView extends StatefulWidget {
  final String label;
  final List<Widget> widgets;
  final bool isDone;
  final bool showCheckBox;
  final bool isCheckBoxEnabled;
  final bool isInitiallyExpanded;
  final bool disableShadow;
  final bool addedPadding;
  final Widget? prependIcon;
  final bool isMandatory;

  ExpandableView(
      {super.key,
      required this.label,
      required this.isDone,
      this.showCheckBox = true,
      required this.widgets,
      this.isInitiallyExpanded = false,
      this.isCheckBoxEnabled = false,
      this.disableShadow = false,
      this.addedPadding = false,
      this.prependIcon,
        this.isMandatory = false});

  @override
  State<ExpandableView> createState() => _ExpandableViewState();
}

class _ExpandableViewState extends BaseRoute<ExpandableView> {
  var isDropViewExpanded = false.obs;
  var dropViewRotateDegree = 45.obs;

  RxBool isDone = false.obs;

  RxBool isEditable = false.obs;

  @override
  void initState() {
    isDone.value = widget.isDone;
    isDropViewExpanded = widget.isInitiallyExpanded.obs;
    isEditable.value = widget.isCheckBoxEnabled;
    if (widget.isInitiallyExpanded) dropViewRotateDegree.value = -45;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: !widget.disableShadow
                ? [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(11, 11),
                      blurRadius: 14,
                    ),
                  ]
                : [],
          ),
          margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.01)),
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {},
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (isDropViewExpanded.value) {
                        dropViewRotateDegree.value = 45;
                        isDropViewExpanded.value = false;
                      } else {
                        dropViewRotateDegree.value = -45;
                        isDropViewExpanded.value = true;
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(
                          top: widget.addedPadding
                              ? getMediaQueryWidth(context, 0.035)
                              : getMediaQueryWidth(context, 0.025),
                          bottom: isDropViewExpanded.isFalse
                              ? getMediaQueryWidth(context, 0.025)
                              : widget.addedPadding
                                  ? getMediaQueryWidth(context, 0.01)
                                  : 0,
                          left: getMediaQueryWidth(context, 0.02),
                          right: getMediaQueryWidth(context, 0.02)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (widget.prependIcon != null)
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.01)),
                                    child: widget.prependIcon ?? Container()),
                              // Icon(Icons.delete),
                              widget.showCheckBox
                                  ? SizedBox(
                                      width: getMediaQueryWidth(context, 0.07),
                                      height: getMediaQueryHeight(context, 0.02),
                                      child: AbsorbPointer(
                                        absorbing: true,
                                        child: Transform.scale(
                                          scale: 0.9,
                                          child: Checkbox(
                                            visualDensity: VisualDensity.compact,
                                            shape: CircleBorder(),
                                            activeColor: Utils.hexColor(AppColor.appPrimaryColor),
                                            value: widget.isDone,
                                            onChanged: isEditable.value
                                                ? (val) {
                                                    print("hello");
                                                  }
                                                : null,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                width: getMediaQueryWidth(context, 0.01),
                              ),
                              Text(
                                widget.label,
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getMediaQueryWidth(context, 0.04)),
                              ),
                              if(widget.isMandatory) Row(
                                children: [
                                  SizedBox(width: getMediaQueryWidth(context, 0.01),),
                                  Text(
                                    "*",
                                    style: TextStyle(
                                        color: Colors.red.shade800,
                                        fontWeight: FontWeight.bold,
                                        fontSize: getMediaQueryWidth(context, 0.05)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Transform.rotate(
                            angle: dropViewRotateDegree * 3.14 / 90,
                            child: Icon(Icons.navigate_next),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              isDropViewExpanded.value
                  ? Column(
                      children: [
                        Divider(
                          thickness: 1,
                        ),
                        ...widget.widgets
                      ],
                    )
                  : Container()
            ],
          ),
        ));
  }
}

class PageNavigatorWidget extends StatefulWidget {
  final String label;
  final bool isDone;
  final bool showCheckBox;
  final bool isEditable;
  final bool disableShadow;
  final bool isMandatory;
  final void Function()? onTap;
  final Function()? notifyParent;

  static _defaultFunction() {}

  PageNavigatorWidget(
      {super.key,
      required this.label,
      required this.isDone,
      this.showCheckBox = true,
      this.isEditable = false,
      this.disableShadow = false,
      this.onTap = PageNavigatorWidget._defaultFunction,
      this.notifyParent,
        this.isMandatory = false});

  @override
  State<PageNavigatorWidget> createState() => _PageNavigatorWidgetState();
}

class _PageNavigatorWidgetState extends BaseRoute<PageNavigatorWidget> {
  var isChecked = false.obs;

  var showCheckB = true.obs;

  RxBool isDone = false.obs;

  RxBool isEditable = false.obs;

  @override
  void initState() {
    showCheckB.value = widget.showCheckBox;
    isDone.value = widget.isDone;
    isChecked = widget.isDone.obs;
    isEditable = widget.isEditable.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: !widget.disableShadow
                ? [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(11, 11),
                      blurRadius: 14,
                    ),
                  ]
                : [],
          ),
          margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.01)),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              // splashColor: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(7),
              onTap: () {},
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: widget.onTap,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.only(
                          top: getMediaQueryWidth(context, 0.025),
                          bottom: getMediaQueryWidth(context, 0.025),
                          left: getMediaQueryWidth(context, 0.02),
                          right: getMediaQueryWidth(context, 0.02)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              showCheckB.value
                                  ? SizedBox(
                                      width: getMediaQueryWidth(context, 0.07),
                                      height: getMediaQueryHeight(context, 0.02),
                                      child: Transform.scale(
                                        scale: 0.9,
                                        child: AbsorbPointer(
                                            absorbing: true,
                                            child: Checkbox(
                                              visualDensity: VisualDensity.standard,
                                              shape: CircleBorder(),
                                              activeColor: Utils.hexColor(AppColor.appPrimaryColor),
                                              value: widget.isDone,
                                              onChanged: isEditable.value ? (val) {} : null,
                                            )),
                                      ),
                                    )
                                  : SizedBox(width: getMediaQueryWidth(context, 0.01)),
                              SizedBox(
                                width: getMediaQueryWidth(context, 0.01),
                              ),
                              Text(
                                widget.label,
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getMediaQueryWidth(context, 0.04)),
                              ),
                              if(widget.isMandatory) Row(
                                children: [
                                  SizedBox(width: getMediaQueryWidth(context, 0.01),),
                                  Text(
                                    "*",
                                    style: TextStyle(
                                        color: Colors.red.shade800,
                                        fontWeight: FontWeight.bold,
                                        fontSize: getMediaQueryWidth(context, 0.05)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

BoxDecoration controllerDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Colors.grey.shade300, width: 1.5),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade300,
        offset: Offset(11, 11),
        blurRadius: 14,
      ),
    ],
  );
}
