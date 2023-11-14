import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:order_search/Utils/logger.dart';
import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/model/global_search_order.dart';
import 'package:order_search/realm/order_picture.dart';
import 'package:order_search/routes/base_route.dart';
import 'package:realm/realm.dart';

class OfflineHelper with AppData {

  static final OfflineHelper _singleton = OfflineHelper._internal();

  OfflineHelper._internal();

  factory OfflineHelper() {
    return _singleton;
  }

  late PicturesQueue picturesQueue;

  var period = const Duration(seconds: 5);

  late StreamSubscription<RealmListChanges<OrderPicture>> listen;

  List<int> executionQueue = [];

  init() {
    try {
      if (databaseHelper.realm.all<PicturesQueue>().isEmpty) {
        databaseHelper.realm.write(() {
          databaseHelper.realm.add<PicturesQueue>(PicturesQueue(queue: []));
        });
      }
      picturesQueue = databaseHelper.realm.all<PicturesQueue>().first;
      if(picturesQueue.queue.isNotEmpty) triggerQueue();
      initPeriodicCaller();
    } catch (ex) {
      print(ex);
    }
  }

  initPeriodicCaller() {
    Timer.periodic(period, (arg) {
      print('calling initPeriodicCaller: pending pictures -> ${picturesQueue.queue.length}');
      if(picturesQueue.queue.isNotEmpty) triggerQueue();
    });
  }

  triggerQueue(){
    print("queue triggered");
    executionQueue.add(executionQueue.isEmpty? executionQueue.length + 1 : executionQueue.reduce(max));
    runQueue();
  }

  Future runQueue() async {
    print("queue started");
    // print("${executionQueue.last}");
    if(executionQueue.isEmpty) return;
    databaseHelper.realm.write(() {
      picturesQueue.queue.where((pending) => !pending.isOnlineSync).forEach((current) async {
        if(await updatePicturesApi(current)){
          databaseHelper.realm.write(() {
            current.isOnlineSync = true;
            picturesQueue.queue.removeWhere((remaining) => remaining.id == current.id);
          });
        }else{
          print("${current.orderId} failed!");
        }
      });
    });
    if(executionQueue.isNotEmpty) executionQueue.removeLast();
  }

  Future<bool> updatePicturesApi(OrderPicture picture) async {
    Response<dynamic>? res;
    try {
      List<MultipartFile> filesList = <MultipartFile>[];
      String? path = picture.localPath;
      if (path == null || Utils.isEmpty(path)) throw Exception("ImageNotFound");
      String fileName = path.split('/').last;
      MultipartFile multipartFile = await MultipartFile.fromFile(path, filename: fileName);
      filesList.add(multipartFile);
      FormData data = FormData.fromMap({
        "pictures[][refer_id]": picture.id,
        "pictures[]item_pictures[][organization_id]": (await sessionManager.getOrgIds()).first,
        "refer": "order",
        "pictures[]item_pictures[][ack_id]": fileName,
        "location_id": picture.csLocationId ?? "",
        "pictures[]item_pictures[][picture_type]": "normal",
        "pictures[]item_pictures[][pic_title]": "POD",
        "pictures[]item_pictures[][pic_code]": "POD",
      });

      print(data.fields);

      data.files.addAll(filesList.map((e) => MapEntry("pictures[]item_pictures[][picture_obj]", e)));

      res = await NetworkUtil()
          .updateDio(EndPoint().UPLOAD_WAREHOUSE_PICTURES, body: data, headers: ApiConstant().getHeaders(await sessionManager.getAccessToken()));

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
        print(res);
        throw Exception();
      }
    } catch (ex, stackTrace) {
      Logger.logMessenger(msgTitle: AppLinks.OrderDetailsNamedRoute, msgBody: {"Exception": ex, "res": res});
      print(stackTrace);
      return false;
    }
    return false;
  }
}
