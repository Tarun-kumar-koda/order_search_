import 'dart:async';

import 'package:dio/dio.dart';
import 'package:order_search/Utils/logger.dart';
import 'package:order_search/Utils/network_util.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
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

  var period = const Duration(seconds: 20);

  bool isQueueBusy = false;

  late StreamSubscription<RealmListChanges<OrderPicture>> listen;

  // List<int> executionQueue = [];

  init() {
    try {
      if (databaseHelper.realm.all<PicturesQueue>().isEmpty) {
        databaseHelper.realm.write(() {
          databaseHelper.realm.add<PicturesQueue>(PicturesQueue(queue: []));
        });
      }
      picturesQueue = databaseHelper.realm.all<PicturesQueue>().first;
      // if(picturesQueue.queue.isNotEmpty) triggerQueue();
      initPeriodicCaller();
    } catch (ex) {
      print(ex);
    }
  }

  initPeriodicCaller() {
    Timer.periodic(period, (arg) async {
      print('pending pictures -> ${picturesQueue.queue.length}');
      print("queue isBusy: $isQueueBusy");
      if (picturesQueue.queue.isNotEmpty) triggerQueue();
    });
  }

  triggerQueue() {
    print("queue triggered");
    print("queue status: $isQueueBusy");
    runQueue();
  }

  Future runQueue() async {
    print("queue started");
    if (picturesQueue.queue.isEmpty || isQueueBusy) return;
    isQueueBusy = true;
    await databaseHelper.realm.write(() async {
      List<Future> futures = [];
      // picturesQueue.queue.where((pending) => !pending.isOnlineSync).forEach((current) async {
      //   if (await updatePicturesApi(current)) {
      //     databaseHelper.realm.write(() {
      //       current.isOnlineSync = true;
      //       picturesQueue.queue.removeWhere((remaining) => remaining.id == current.id);
      //     });
      //   } else {
      //     print("${current.orderId} failed!");
      //   }
      // });
      picturesQueue.queue.where((pending) => !pending.isOnlineSync).forEach((current) async {
        futures.add(updatePictureAndMarkAsComplete(current));
      });
      await futures.wait;
    });
    isQueueBusy = false;
  }

  Future updatePictureAndMarkAsComplete(OrderPicture current) async {
    if (await updatePicturesApi(current)) {
      databaseHelper.realm.write(() {
        current.isOnlineSync = true;
        picturesQueue.queue.removeWhere((remaining) => remaining.id == current.id);
      });
    } else {
      print("${current.orderId} failed!");
    }
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
