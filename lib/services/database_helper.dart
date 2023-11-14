import 'package:order_search/services/session_manager.dart';
import 'package:realm/realm.dart';

import '../realm/order_picture.dart';

class DatabaseHelper with RealmServices {

  static final DatabaseHelper _singleTon = DatabaseHelper._internal();

  factory DatabaseHelper() => _singleTon;

  DatabaseHelper._internal();

  RealmList<OrderPicture> get getPictures {
    RealmList<OrderPicture> pictures = RealmList([]);
    pictures.addAll(realm.all<OrderPicture>());
    return pictures;
  }

}
