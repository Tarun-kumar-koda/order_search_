import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/logger.dart';
import 'dart:developer' as dev;

import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/entity/parent_responce.dart';
import 'package:order_search/entity/scanned_customer_details.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/services/session_manager.dart';

class WareHouseHomeController extends GetxController {
  NetworkUtil networkUtil = NetworkUtil();
  SessionManager sessionManager = SessionManager().getInstance();
  TextEditingController selectFilterController = TextEditingController();
  List<TextEditingController> dockEditTextController =
      <TextEditingController>[].obs;

  var userId, accessToken, refreshToken;
  var message = "".obs;
  var orderList = <ScannedCustomerDetails>[].obs;
  var parentRes = ParentResp().obs;
  var currentWarehouseName = "".obs;
  var isCameraPermissionGranted = false.obs;
  var useLessCheck = true;

  var isConfigExpanded = false.obs;
  var configsDegree = -45.obs;
  var wareHouseNamesList = [].obs;
  TextEditingController wareHouseGateNumText = TextEditingController();
  TextEditingController wareHouseTruckNumText = TextEditingController();
  String? selectedWareHouse;

  //Not using in current changes.
  var currentStatus = "".obs;
  var newStatusCount = "".obs;
  var recStatusCount = "".obs;
  var excStatusCount = "".obs;
  var othStatusCount = "".obs;

  late OrderPicture? pictureObj;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future getOrderData(String val) async {
    Utils.showLoadingDialog();
    dev.log('inside getOrderData ${val} ');
    accessToken = await sessionManager.getAccessToken();
    var orgId = await sessionManager.getOrgIds();
    dev.log(
        'inside getOrderData org id & access token is ${orgId} ${accessToken} ');
    refreshToken = await this.sessionManager.getRefreshToken();
    var res = await networkUtil.getDio(
        ApiConstant.endPoint.CUSTOMER_INFO, "GET_ORDER_DETAILS",
        body: {
          "search_value": val,
          "org_id": orgId.first,
        },
        headers: ApiConstant().getHeaders(accessToken));
    Utils.hideLoadingDialog();
    if (res != null) {
      if (res.statusCode == 200) {
        ParentResp itemDetailsResp = ParentResp.fromJson(res.data);
        if (itemDetailsResp.scannedCustomerDetails != null &&
            itemDetailsResp.scannedCustomerDetails!.length > 0) {
          orderList.value = itemDetailsResp.scannedCustomerDetails!;
        } else if (itemDetailsResp.error != null &&
            itemDetailsResp.error!.length > 0) {
          Utils.showAlertDialog(res.data["errors"][0]);
        }
        Logger.logMessenger(msgTitle: "order search response",msgBody: {"data":jsonEncode(res.data)});
      } else if (res.statusCode == 401) {
        getRefreshTokenCustomerInfo(val);
      } else if (res.data["errors"] != null) {
        var errorMessage = res.data["errors"] as List<dynamic>;
        if (errorMessage.length > 0) {
          Utils.showAlertDialog(res.data["errors"][0]);
        }
      } else {
        Utils.showAlertDialog("Unable to fetch data.");
      }
    }

    // orderList.addAll([ScannedCustomerDetails(accountName: "ad",orderNumber: Random().nextInt(1000).toString()),ScannedCustomerDetails(accountName: "ad",orderNumber: Random().nextInt(1000).toString()),ScannedCustomerDetails(accountName: "ad",orderNumber: Random().nextInt(1000).toString()),ScannedCustomerDetails(accountName: "ad",orderNumber: Random().nextInt(1000).toString()),ScannedCustomerDetails(accountName: "ad",orderNumber: Random().nextInt(1000).toString()),ScannedCustomerDetails(accountName: "ad",orderNumber: Random().nextInt(1000).toString())]);
  }

  getRefreshTokenCustomerInfo(String val) async {
    Utils.showLoadingDialog();
    try {
      var res = await networkUtil.postDio(
          ApiConstant.endPoint.REFRESH_TOKEN, "REFRESH_TOKEN",
          body: getTokenParam());
      Utils.hideLoadingDialog();
      if (res != null) {
        if (res.statusCode == 200) {
          sessionManager.setRefreshToken(res.data["refresh_token"]);
          sessionManager
              .setAccessToken("${"bearer"} ${res.data["access_token"]}");
          Future.delayed(Duration(seconds: 1), () {
            getOrderData(val);
          });
        } else if (res.statusCode == 401) {
          sessionManager.clearPreferences();
          Get.offNamed(AppLinks.loginNamedRoute);
          Utils.showToastMessage("Token expired");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> getTokenParam() {
    var body = <String, dynamic>{
      ApiConstant.param.REFRESH_TOKEN: refreshToken,
      ApiConstant.param.CLIENT_ID: ApiConstant.clientId,
      ApiConstant.param.CLIENT_SECRET: ApiConstant.clientSecretKey,
      ApiConstant.param.GRANT_TYPE: "refresh_token",
    };
    return body;
  }

  // fetchImagesFromDb(ScannedCustomerDetails orderDetails){
  //   pictureObj = sessionManager.realm.query<OrderPicture>("orderNumber == '${orderDetails.orderNumber}'").firstOrNull!;
  // }

  // Future updatePicturesApi(OrderPicture picture) async {
  //   late dio.Response<dynamic>? res;
  //   Utils.showLoadingDialog();
  //   try {
  //     List<dio.MultipartFile> filesList = <dio.MultipartFile>[];
  //     String? path = picture.localPath;
  //     if (path == null || Utils.isEmpty(path)) throw Exception("ImageNotFound");
  //     String fileName = path.split('/').last;
  //     dio.MultipartFile multipartFile = await dio.MultipartFile.fromFile(path, filename: fileName);
  //     filesList.add(multipartFile);
  //     dio.FormData data = dio.FormData.fromMap({
  //       "location_id": stopOrder.value.csLocationId,
  //       "refer": "order",
  //       "pictures[][refer_id]": stopOrder.value.orderId,
  //       "pictures[]item_pictures[][picture_type]": element.imageType,
  //       "pictures[]item_pictures[][ack_id]": UniqueKey(),
  //       "pictures[]item_pictures[][pic_title]": element.picTitle,
  //       "pictures[]item_pictures[][pic_code]": element.picCode,
  //       "pictures[]item_pictures[][sign_by]": element.signBy,
  //       "pictures[]item_pictures[][captured_at]": element.capturedAt,
  //       "pictures[]item_pictures[][title_by_relation]": element.titleByRelation,
  //       "pictures[]item_pictures[][latitude]": -12,
  //       "pictures[]item_pictures[][longitude]": 32
  //     });
  //
  //     data.files.addAll(filesList.map((e) => MapEntry("pictures[]item_pictures[][picture_obj]", e)));
  //
  //     res = await NetworkUtil().updateDio(EndPoint().UPLOAD_ORDER_ITEM_PHOTOS,
  //         body: data, headers: ApiConstant().getHeaders(accessToken));
  //
  //     if (res != null) {
  //       Logger.logMessenger(msgTitle: AppLinks.OrderDetailsNamedRoute, msgBody: {
  //         "status code": res?.statusCode,
  //         "status message": res?.statusMessage,
  //       });
  //       if (res?.statusCode == 201) {
  //         /// save into db
  //         List<PicturesModel> lst = [];
  //         res?.data['pictures_obj']['pictures'][0]['pictures'].forEach((picture) {
  //           PicturesModel pictureModel = PicturesModel.fromJson(picture);
  //           databaseHelper.realm.write(() {
  //             String ack = picture['ack_id'];
  //             Pictures? pictureObj = databaseHelper.realm
  //                 .query<Pictures>(
  //               'ackId == "$ack"',
  //             )
  //                 .firstOrNull;
  //             if (pictureObj == null) {
  //               return false;
  //             }
  //             pictureObj = ToRealm.convertFromPicturesModel(pictureModel);
  //             Logger.logMessenger(
  //                 msgTitle: AppLinks.OrderDetailsNamedRoute + "/images api",
  //                 msgBody: {"realm: ${pictureObj.ackId}": "response: ${pictureModel.ackId}"});
  //           });
  //           lst.add(pictureModel);
  //         });
  //       } else if (res?.statusCode == 204) {
  //         throw Exception(res?.statusCode);
  //       }
  //     } else
  //       throw Exception();
  //   } on ImagePathNotFound catch (ex, stackTrace) {
  //     Logger.logMessenger(
  //         msgTitle: AppLinks.OrderDetailsNamedRoute, msgBody: {"ImagePathNotFound": ex, "stack trace": stackTrace});
  //   } catch (ex, stackTrace) {
  //     Logger.logMessenger(
  //         msgTitle: AppLinks.OrderDetailsNamedRoute, msgBody: {"Exception": ex, "stack Trace": stackTrace});
  //   }
  //   Utils.hideLoadingDialog();
  // }

}
