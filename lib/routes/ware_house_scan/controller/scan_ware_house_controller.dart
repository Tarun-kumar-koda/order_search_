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
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/routes/ware_house_scan/model/warehouse_ids.dart';
import 'package:order_search/routes/ware_house_scan/model/warehouse_response_model.dart';
import 'package:order_search/services/session_manager.dart';

import '../../../model/global_search_order.dart';

class WareHouseHomeController extends GetxController {
  NetworkUtil networkUtil = NetworkUtil();
  SessionManager sessionManager = SessionManager().getInstance();
  TextEditingController selectFilterController = TextEditingController();
  List<TextEditingController> dockEditTextController =
      <TextEditingController>[].obs;

  var userId, accessToken, refreshToken;
  var message = "".obs;
  var orderList = <CustomerOrders>[].obs;
  var whLocList = <Locations>[].obs;
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
  late GlobalKey<FormState> formKey;
  late Locations selectedWarehouse;
  late OrderPicture? pictureObj;
  var isApiCompleted = false.obs;

  // List<WarehouseId> warehouseIds = [WarehouseId(name: "choose a warehouse"),WarehouseId(name: "AUSTIN",id: "62b59902822dd6839e8ddbbf"),
  // WarehouseId(name: "SAN ANTONIO",id: "62b59998822dd6aed18ab8c5"),
  // WarehouseId(name: "QA Warehouse",id: "643feaee822dd6af9754a33d")];

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getWarehouseList();
  }

  Future getOrderData(String val, String whId) async {
    Utils.showLoadingDialog();
    dev.log('inside getOrderData ${val} && warehouseId: ${whId}');
    accessToken = await sessionManager.getAccessToken();
    // var orgId = "";
    var orgId = (await sessionManager.getOrgIds()).firstOrNull;
    dev.log(
        'inside getOrderData org id & access token is ${orgId} ${accessToken} ');
    refreshToken = await this.sessionManager.getRefreshToken();
    var res = await networkUtil.getDio(
        ApiConstant.endPoint.GLOBAL_SEARCH_ORDER, "GET_ORDER_DETAILS",
        body: {
          "global_search":true,
          "page":1,
          "per_page":40,
          "status":"",
          "operation_code":"COI",
          "stats_only":"false",
          "current_role":"admin",
          "org_id": orgId,
          "warehouse_ids": whId,
          "customer_order_number": val.toUpperCase()
        },
        headers: ApiConstant().getHeaders(accessToken));
    Utils.hideLoadingDialog();
    if (res != null) {
      if (res.statusCode == 200) {
        GlobalSearchBaseResponse globalSearchBaseResponse = GlobalSearchBaseResponse.fromJson(res.data);
        if (globalSearchBaseResponse.customerOrders != null &&
            globalSearchBaseResponse.customerOrders!.length > 0) {
          orderList.value = globalSearchBaseResponse.customerOrders!;
        }
        Logger.logMessenger(msgTitle: "order search response",msgBody: {"data":jsonEncode(res.data)});
      } else if (res.statusCode == 401) {
        getRefreshTokenCustomerInfo(val,whId);
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

  getRefreshTokenCustomerInfo(String val,String whId) async {
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
            getOrderData(val,whId);
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

  Future getWarehouseList() async {
    Utils.checkNetworkStatus().then((value) async {
      if(value){
        isApiCompleted.value = false;
        Utils.showLoadingDialog();
        String orgId = (await sessionManager.getOrgIds()).first;
        try {
          var res = await NetworkUtil().getDio("${ApiConstant.endPoint.GET_WAREHOUSE_LIST}", "Warehouse List",
            headers: ApiConstant().getHeaders(await sessionManager.getAccessToken()),
            body: {
              "page":1,
              "location_type":"WH",
              "operation_code":"WHI",
              "skip_wh_check":true,
              "org_id": orgId
            },
          );

          isApiCompleted.value = true;
          Utils.hideLoadingDialog();
          if (res != null) {
            if (res.statusCode == 200) {
              WarehouseResponseModel warehouseResponseModel = WarehouseResponseModel.fromJson(res.data);
              if (warehouseResponseModel.locations != null &&
                  warehouseResponseModel.locations!.isNotEmpty) {
                whLocList.value = warehouseResponseModel.locations!;
              }
            } else if (res.statusCode == 401) {

            } else if (res.data["errors"] != null) {
              var errorMessage = res.data["errors"] as List<dynamic>;
              if (errorMessage.isNotEmpty) {
                Utils.showAlertDialog(res.data["errors"][0]);
              }
            } else {
              Utils.showAlertDialog("Unable to fetch data.");
            }
          }

        } catch (ex) {
          throw Exception();
        }
      }else{
        isApiCompleted.value = true;
        Utils.showAlertDialog(AppConstant.networkNotConnected);
      }
    });
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
