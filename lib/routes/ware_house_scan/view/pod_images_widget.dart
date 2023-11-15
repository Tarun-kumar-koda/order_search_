import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/widgets/pod_images_widget/image_viewer_page.dart';
import 'package:order_search/widgets/toolbar/toolbar_controller.dart';

import '../../../Utils/utils.dart';
import '../../../constant/app_constant.dart';
import '../../../entity/scanned_customer_details.dart';
import '../../../model/global_search_order.dart';
import '../../../widgets/pod_images_widget/image_picker_controller.dart';
import '../../base_route.dart';
import '../controller/scan_ware_house_controller.dart';

class PodImagesWidget extends StatefulWidget {
  final Order orderDetails;
  // final CustomerOrders customerOrders;
  final GlobalKey parentKey;
  final int widgetIndex;

  // final PicturesQueue picturesQueue;

  // const PodImagesWidget({super.key, required this.orderDetails, required this.parentKey, required this.widgetIndex});
  const PodImagesWidget({super.key, required this.orderDetails, required this.parentKey, required this.widgetIndex});

  @override
  State<PodImagesWidget> createState() => _PodImagesWidgetState();
}

class _PodImagesWidgetState extends BaseRoute<PodImagesWidget> {
  late ImagePickerController imagePickerController;

  ToolBarController toolBarController = Get.put(ToolBarController());

  WareHouseHomeController wareHouseHomeController = Get.put(WareHouseHomeController());

  @override
  void initState() {
    // imagePickerController = Get.put(ImagePickerController(orderDetails: widget.orderDetails));
    imagePickerController =  ImagePickerController(orderDetails: widget.orderDetails);
imagePickerController.onInit();
    super.initState();
  }

  @override
  void dispose() {
    // imagePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Divider(color: Colors.black,),
            Padding(
              padding: EdgeInsets.only(
                  left: getMediaQueryHeight(context, 0.01), bottom: getMediaQueryHeight(context, 0.006)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Icon(Icons.camera_alt_outlined,
                          color: Colors.grey.shade600, size: getMediaQueryWidth(context, 0.045))),
                  SizedBox(
                    width: getMediaQueryWidth(context, 0.01),
                  ),
                  Text(
                    "POD",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        fontSize: getMediaQueryWidth(context, 0.04)),
                  ),
                  SizedBox(
                    width: getMediaQueryWidth(context, 0.03),
                  )
                ],
              ),
            ),
            if (imagePickerController.imagesList.value.length > 0 || imagePickerController.isPageEditable)
              Container(
                height: getMediaQueryWidth(context, 0.40),
                child: imagePickerController.imagesList.value.length > 0
                    ? ListView.builder(
                        //physics: AppAnimation.physics,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(getMediaQueryWidth(context, 0.01)),
                        scrollDirection: Axis.horizontal,
                        itemCount: imagePickerController.imagesList.value.length,
                        itemBuilder: (BuildContext context, int index) => Obx(() {
                              if (index == imagePickerController.imagesList.value.length - 1 &&
                                  imagePickerController.imagesList.value.length < 10) {
                                Row(
                                  children: [
                                    getImageViewerWidget(index),
                                    if (imagePickerController.isPageEditable)
                                      addImage(imagePickerController.imagesList.value.length + 1)
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  getImageViewerWidget(index),
                                  // if (imagePickerController.pictureObj.value!.isOnlineSync)
                                  //   Row(
                                  //     children: [
                                  //       SizedBox(
                                  //         width: getMediaQueryWidth(context, 0.08),
                                  //       ),
                                  //       Icon(
                                  //         Icons.cloud_done,
                                  //         color: Colors.green,
                                  //       ),
                                  //       SizedBox(
                                  //         width: getMediaQueryWidth(context, 0.01),
                                  //       ),
                                  //       Text(
                                  //         "uploaded",
                                  //         textAlign: TextAlign.justify,
                                  //         style: TextStyle(
                                  //             color: Colors.grey.shade600,
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: getMediaQueryWidth(context, 0.04)),
                                  //       ),
                                  //     ],
                                  //   )
                                ],
                              );
                            }))
                    : imagePickerController.isPageEditable
                        ? addImage(imagePickerController.imagesList.value.length + 1)
                        : Container(),
              ),

            SizedBox(
              height: getMediaQueryHeight(context, 0.02),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: getMediaQueryWidth(context, 0.28),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                              top: getMediaQueryHeight(context, 0.009),
                              bottom: getMediaQueryHeight(context, 0.009),
                              left: getMediaQueryWidth(context, 0.02),
                              right: getMediaQueryWidth(context, 0.02))),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                          backgroundColor: !Utils.isEmpty(imagePickerController.orderDetails.localPath) &&
                                  !imagePickerController.orderDetails.isOnlineSync!
                              ? MaterialStateProperty.all<Color>(Colors.indigo)
                              : MaterialStateProperty.all<Color>(Colors.grey),
                          // backgroundColor:  MaterialStateProperty.all<Color>(Utils.hexColor(AppColor.appPrimaryColor)),
                        ),
                        onPressed: !Utils.isEmpty(imagePickerController.orderDetails.localPath) &&
                                !imagePickerController.orderDetails.isOnlineSync!
                            ? () async {
                                Utils.showLoadingDialog();
                                Future.delayed(const Duration(milliseconds: 600), () {
                                  Utils.hideLoadingDialog();
                                });
                                // if (await imagePickerController.updatePicturesApi()) {
                                if (imagePickerController.pushImageToQueue(imagePickerController.orderDetails)) {
                                  setState(() {
                                    wareHouseHomeController.orderList.removeAt(widget.widgetIndex);
                                    wareHouseHomeController.orderList.refresh();
                                    imagePickerController.orderDetails.isOnlineSync = true;
                                  });
                                }
                              }
                            : null,
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          Text(
                            "Upload",
                            style: TextStyle(color: Colors.white, fontSize: getMediaQueryWidth(context, 0.04)),
                          ),
                        ]))),

                // ElevatedButton(onPressed: (){Utils.showToastMessage(context: context,"uploaded successfully");}, child: Text("toast"))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addImage(int index) {
    return Container(
      height: getMediaQueryWidth(context, 0.40),
      width: getMediaQueryWidth(context, 0.40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(4, 4),
            blurRadius: 7,
          ),
        ],
      ),
      margin: EdgeInsets.all(getMediaQueryWidth(context, 0.01)),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            imagePickerController.insertImageIntoDb();
            widget.parentKey.currentState!.setState(() {});
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                color: Colors.grey.shade600,
              ),
              const SizedBox(
                height: 10,
              ),
              index != 1
                  ? Text(
                      'Pic $index',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: getMediaQueryWidth(context, 0.035),
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'add',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: getMediaQueryWidth(context, 0.035),
                          fontWeight: FontWeight.bold),
                    )
            ],
          ),
        ),
      ),
    );
  }

  // @deprecated
  // List<double> getImageSize(String imagePath) {
  //   // Read the image file into memory
  //   final File imageFile = File(imagePath);
  //   final Uint8List uint8List = imageFile.readAsBytesSync();
  //
  //   // Decode the image using the 'image' package
  //   final img.Image? image = img.decodeImage(uint8List);
  //   if (image != null) {
  //     // Return the dimensions as a Size object
  //     return [image.width.toDouble() / 4.4, image.height.toDouble()];
  //   } else {
  //     return [0, 0];
  //   }
  // }

  Widget getImageViewerWidget(int index) {
    bool isNetwork = false;
    // Logger.logMessenger(msgTitle: "pod_images_widget/ getImageViewerWidget()", msgBody: {
    //   "pic_title": imagePickerController.imagesList.value[index].picTitle,
    //   "local": imagePickerController.imagesList.value[index].picture?.localPath,
    //   "url": imagePickerController.imagesList.value[index].picture?.url,
    // });
    // if (kDebugMode) {
    //   print(imagePickerController.imagesList.value.length);
    // }
    return GestureDetector(
      onTap: () {
        print(imagePickerController.orderDetails.customerOrderNumber);
        Get.to(
            () => ImageViewer(
                  isPageEditable: imagePickerController.isPageEditable,
                  isNetwork: isNetwork,
                  title: "",
                  url: "",
                  path: imagePickerController.imagesList.value[index],
                  index: index,
                ),
            transition: Transition.native,
            duration: const Duration(milliseconds: 200));
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // color: Colors.black12,
              margin: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.01)),
              height: getMediaQueryHeight(context, 0.40),
              width: getMediaQueryWidth(context, 0.40),
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: /*(Utils.isEmpty(imagePickerController.imagesList.value[index].picture?.url))*/
                      /*?*/ Image.file(
                    File.fromUri(
                      Uri.file(
                        imagePickerController.imagesList.value[index],
                      ),
                    ),
                  )
                  // : FadeInImage.assetNetwork(
                  //     placeholder: "assets/gifs/pod_loading.gif",
                  //     image: imagePickerController.imagesList.value[index].picture?.url ?? "")),
                  ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black38,
              ),
              padding: EdgeInsets.symmetric(horizontal: getMediaQueryWidth(context, 0.05)),
              height: 20,
              child: imagePickerController.orderDetails.isOnlineSync!
                  ? Icon(
                      Icons.cloud_done,
                      color: Colors.green.shade300,
                      size: 15,
                    )
                  : const Icon(
                      Icons.warning,
                      color: Colors.grey,
                      size: 15,
                    ),
            ),
          ),
          if (imagePickerController.isPageEditable)
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 40,
                height: 40,
                decoration: const BoxDecoration(color: Colors.black26, shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      imagePickerController.delete(index);
                      widget.parentKey.currentState!.setState(() {});
                    });
                  },
                  icon: Icon(Icons.delete, color: Colors.red.shade300, size: 22),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
