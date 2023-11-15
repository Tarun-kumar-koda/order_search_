import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/routes/base_route.dart';
import 'package:order_search/services/offlinehelper.dart';
import 'package:order_search/widgets/toolbar/toolbar_controller.dart';
import 'package:realm/realm.dart';

import '../../Utils/logger.dart';
import '../../Utils/network_util.dart';
import '../../Utils/utils.dart';
import '../../constant/api_constant.dart';
import '../../constant/app_constant.dart';
import '../../entity/scanned_customer_details.dart';
import '../../model/global_search_order.dart';
import '../../my_app.dart';
import 'file_manager.dart';
import 'package:dio/dio.dart' as dio;

typedef Rxl = Rx<List<String>>;

class ImagePickerController extends GetxController with AppData {
  Rxl imagesList = Rxl([]);
  static bool debug = false;

  bool isPageEditable = true;

  late PicturesQueue picturesQueue;

  // late Rx<OrderPicture?> pictureObj;

  late StreamSubscription<RealmListChanges<OrderPicture>> listen;

  late Order orderDetails;
  late CustomerOrders customerOrders;

  ToolBarController toolBarController = Get.put(ToolBarController());

  ImagePickerController({required this.orderDetails});

  @override
  void onInit() {
    if(databaseHelper.realm.all<PicturesQueue>().isEmpty){
      databaseHelper.realm.write((){
        databaseHelper.realm.add<PicturesQueue>(PicturesQueue());
      });
    }
    picturesQueue = databaseHelper.realm.all<PicturesQueue>().first;
    // picturesQueue = databaseHelper.realm.all<PicturesQueue>().first;
    fetch();
    // _initiateListener();
    checkEditable();
    super.onInit();
  }

  _initiateListener(){
    listen = picturesQueue.queue.changes.listen((event) {
      print("&&&${event.list.length}");
    });

    listen.onData((data) {
      print(data.inserted);
    });
  }

  void fetch() async {
    imagesList.value.clear();
    // pictureObj = (sessionManager.realm.query<OrderPicture>("orderNumber == '${orderDetails.customerOrderNumber!}'").firstOrNull).obs;
    // if (pictureObj.value != null) imagesList.value.add(pictureObj.value!.localPath!);
    if(!Utils.isEmpty(orderDetails.localPath)) imagesList.value.add(orderDetails.localPath!);
    imagesList.refresh();
  }

  checkEditable() {}

  bool delete(int index) {
    // sessionManager.realm.write(() {
    //   sessionManager.realm.delete<OrderPicture>(pictureObj.value!);
    // });
    orderDetails.localPath = "";
    orderDetails.isOnlineSync = false;
    fetch();
    return true;
  }

  void insertImageIntoDb() async {
    PICK_IMAGE? choice = await showCameraRequestPermissionBottomSheet(Get.context!);
    if (choice == null) return;
    XFile? temp = await FileManager.imageHandler(mode: choice);
    String? path = temp?.path;
    try {
      if (path == '' || path == null) return;
      // sessionManager.realm.write(() {
      //   sessionManager.realm.add<OrderPicture>(OrderPicture(ObjectId().toString(), orderDetails.customerOrderNumber ?? "", false,
      //       localPath: path,
      //       ackId: Object().toString(),
      //       capturedAt: DateTime.now().toUtc().toString(),
      //       imageType: "normal",
      //       picTitle: "POD"));
      // });
      orderDetails.localPath = path;
      fetch();
    } catch (ex) {
      print(ex);
      Utils.showToastMessage("Something went wrong");
      return;
    }
  }

  Future<PICK_IMAGE?> showCameraRequestPermissionBottomSheet(BuildContext context) async {
    double mqH = context.mediaQuery.size.height;
    double mqW = context.mediaQuery.size.width;
    PICK_IMAGE? mode;
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: mqH * 0.15,
          child: Column(
            children: [
              ListTile(
                visualDensity: VisualDensity.comfortable,
                leading: Icon(Icons.camera_alt, size: mqW * 0.06),
                title: Text(
                  'Take a picture',
                  style: TextStyle(fontSize: mqW * 0.05),
                ),
                onTap: () async {
                  mode = PICK_IMAGE.CAMERA;
                  Get.back();
                  return;
                },
              ),
              ListTile(
                leading: Icon(Icons.image, size: mqW * 0.06),
                title: Text('Choose from gallery', style: TextStyle(fontSize: mqW * 0.05)),
                onTap: () async {
                  mode = PICK_IMAGE.GALLERY;
                  Get.back();
                  return;
                },
              ),
            ],
          ),
        );
      },
    );
    return mode;
  }

  Future<PICK_IMAGE?> showCameraRequestPermission() async {
    PICK_IMAGE? mode;
    await showDialog(
      builder: (context) => Container(
        width: double.infinity,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Row(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(CircleBorder()),
                          fixedSize: MaterialStatePropertyAll(Size(50, 50))),
                      onPressed: () {
                        mode = PICK_IMAGE.GALLERY;
                        Get.back();
                        return;
                      },
                      child: const Icon(
                        Icons.image,
                        color: Colors.black,
                      )),
                  const Text("Gallery")
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(CircleBorder()),
                          fixedSize: MaterialStatePropertyAll(Size(50, 50))),
                      onPressed: () {
                        mode = PICK_IMAGE.CAMERA;
                        Get.back();
                        return;
                      },
                      child: const Icon(
                        Icons.camera_alt_sharp,
                        color: Colors.black,
                      )),
                  const Text("Camera")
                ],
              ),
            ]),
          ),
        ),
      ),
      context: MyApp.navigatorKey.currentState!.overlay!.context,
    );
    return mode;
  }

  bool pushImageToQueue(Order orderDetails){
    try {
      databaseHelper.realm.write(() {
        OrderPicture picture = OrderPicture(orderDetails.id!,Object().toString(), orderDetails.customerOrderNumber!,false,localPath: orderDetails.localPath);
        databaseHelper.realm.add<OrderPicture>(picture);
        picturesQueue.queue.add(picture);
      });
      OfflineHelper().triggerQueue();
      return true;
    }catch(ex){
      print(ex);
      return false;
    }
  }

  Future<bool> updatePicturesApi() async {
    late dio.Response<dynamic>? res;
    bool isTransferOrder = orderDetails.typeOfOrder == "T" ? true : false;
    String destLocationId = "";
    if(customerOrders.destination != null && customerOrders.destination!.id != null){
      destLocationId = customerOrders.destination!.id ?? "";
    }
    try {
      List<dio.MultipartFile> filesList = <dio.MultipartFile>[];
      String? path = orderDetails.localPath;
      if (path == null || Utils.isEmpty(path)) throw Exception("ImageNotFound");
      String fileName = path.split('/').last;
      dio.MultipartFile multipartFile = await dio.MultipartFile.fromFile(path, filename: fileName);
      filesList.add(multipartFile);
      dio.FormData data = dio.FormData.fromMap({
        "pictures[][refer_id]": orderDetails.id ?? "",
        "pictures[]item_pictures[][organization_id]": (await sessionManager.getOrgIds()).first,
        "refer": "order",
        "pictures[]item_pictures[][ack_id]": fileName,
        "location_id": isTransferOrder ? destLocationId : orderDetails.csLocationId ?? "",
        "pictures[]item_pictures[][picture_type]": "normal",
        "pictures[]item_pictures[][pic_title]": "POD",
        "pictures[]item_pictures[][pic_code]": "POD",
      });

      data.files.addAll(filesList.map((e) => MapEntry("pictures[]item_pictures[][picture_obj]", e)));

      res = await NetworkUtil().updateDio(EndPoint().UPLOAD_WAREHOUSE_PICTURES,
          body: data, headers: ApiConstant().getHeaders(await sessionManager.getAccessToken()));

      if (res != null) {
        Logger.logMessenger(msgTitle: AppLinks.OrderDetailsNamedRoute, msgBody: {
          "status code": res.statusCode,
          "status message": res.statusMessage,
        });
        if (res.statusCode == 201) {
          print(res.data);
          return true;
        }
      } else {
        throw Exception();
      }
    } catch (ex, stackTrace) {
      Logger.logMessenger(
          msgTitle: AppLinks.OrderDetailsNamedRoute, msgBody: {"Exception": ex, "res": res});
      print(stackTrace);
      return false;
    }
    return false;
  }

  void uploadButtonHandler() {
    Utils.showLoadingDialog();
    Future.delayed(const Duration(milliseconds: 600),() {
      Utils.hideLoadingDialog();
    });
    // if (await imagePickerController.updatePicturesApi()) {
    if (pushImageToQueue(orderDetails)) {
      // setState(() {
        orderDetails.isOnlineSync = true;
      // });

    }
  }
}
