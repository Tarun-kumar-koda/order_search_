
import 'package:realm/realm.dart';

part 'order_picture.g.dart';

@RealmModel()
class $OrderPicture{
  late String id;
  late String orderNumber;
  late String? localPath;
  late String? url;
  late String? ackId;
  late String? capturedAt;
  late String? imageType;
  late String? picTitle;
  late bool isOnlineSync;

  // Picture fromJson(Map<String,dynamic> json){
  //
  // }
}