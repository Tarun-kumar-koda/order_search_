import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:order_search/routes/base_route.dart';

import '../../Utils/utils.dart';
import 'image_picker_controller.dart';

class ImageViewer extends StatefulWidget {
  final String? path;

  final int index;

  final bool isNetwork;

  final bool isPageEditable;

  final String url;

  final String title;



  ImageViewer({super.key, required this.index, this.path, this.isNetwork = false, required this.url,required this.title, required this.isPageEditable});

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends BaseRoute<ImageViewer> {
  ImagePickerController? imagePickerController;

  Rx<int> turns = 0.obs;

  bool isVisible = true;

  bool isEditable = true;

  RxBool isAvailable = true.obs;

  @override
  void initState() {
    super.initState();
    isAvailable = (!Utils.isEmpty(widget.path) || !Utils.isEmpty(widget.url)).obs;
    // imagePickerController = Get.put(ImagePickerController(orderDetailsController: widget.stopOrder?.orderId ?? ""));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black26, // status bar color
    ));
  }

  @override
  void dispose() {
    SystemChrome.restoreSystemUIOverlays();
    super.dispose();
    print("dispose image page");
  }

  Widget getAppBar2() {
    return SafeArea(
        child: Align(
      alignment: Alignment.topCenter,
      child: Visibility(
        visible: isVisible,
        maintainState: true,
        maintainAnimation: true,
        child: AnimatedOpacity(
          curve: Curves.bounceInOut,
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            color: Colors.black26,
            padding: EdgeInsets.symmetric(vertical: getMediaQueryHeight(context, 0.02)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: getMediaQueryWidth(context, 0.02),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
                    ),
                    Text("${widget.title}",
                        style: TextStyle(fontSize: getMediaQueryWidth(context, 0.05), color: Colors.white)),
                  ],
                ),
                isAvailable.isTrue
                    ? Container(
                  padding: EdgeInsets.only(right: getMediaQueryWidth(context, 0.03)),
                        width: getMediaQueryWidth(context, 0.3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if(widget.isPageEditable) IconButton(
                              onPressed: () {

                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: getMediaQueryWidth(context, 0.02),
                            ),
                            IconButton(
                              onPressed: () {
                                if (turns > 3) {
                                  turns.value = 1;
                                } else {
                                  turns.value += 1;
                                }
                                print(turns);
                              },
                              icon: Icon(
                                // size: 27,
                                Icons.rotate_right_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Obx(() => getImage()),
          if(widget.isPageEditable) getEditorButton(),
          getAppBar2(),
        ],
      ),
    );
  }

  Widget getEditorButton() => AnimatedOpacity(
        curve: Curves.bounceInOut,
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: EdgeInsets.only(top: getMediaQueryHeight(context, 0.83)),
          child: Container(
            decoration: BoxDecoration(color: Colors.black26),
            child: SizedBox(
              width: getMediaQueryWidth(context, 1),
              child: OutlinedButton(
                style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Colors.white10),
                    surfaceTintColor: MaterialStatePropertyAll(Colors.black12)),
                onPressed: isVisible
                    ? () {
                        // setState(() {
                        //   showAppBar = showAppBar ? false : true;
                        // });
                      }
                    : null,
                child: Visibility(
                  visible: isVisible,
                  maintainState: true,
                  maintainAnimation: true,
                  child: Center(
                    child: Icon(Icons.edit, size: getMediaQueryWidth(context, 0.07), color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget getImage() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isVisible = isVisible ? false : true;
        });
      },
      child: isAvailable.value
          ? InteractiveViewer(
              minScale: 0.2,
              maxScale: 3,
              child: Center(
                child: SizedBox(
                  height: getMediaQueryHeight(context, 1),
                  width: getMediaQueryWidth(context, 1),
                  child: RotatedBox(
                    quarterTurns: turns.value,
                    child: !widget.isNetwork
                        ? Image.file(
                            File.fromUri(
                              Uri.file(
                                widget.path ?? "",
                              ),
                            ),
                          )
                        : Image.network(widget.url),
                  ),
                ),
              ),
            )
          : Container(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.yellow,
                    size: getMediaQueryWidth(context, 0.06),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Image is Unavailable",
                    style: TextStyle(color: Colors.white, fontSize: getMediaQueryWidth(context, 0.06)),
                  ),
                ],
              )),
            ),
    );
  }
}
