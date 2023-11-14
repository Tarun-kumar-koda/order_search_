// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_picture.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class OrderPicture extends $OrderPicture
    with RealmEntity, RealmObjectBase, RealmObject {
  OrderPicture(
    String id,
    String orderId,
    String orderNumber,
    bool isOnlineSync, {
    String? localPath,
    String? url,
    String? ackId,
    String? capturedAt,
    String? imageType,
    String? picTitle,
    String? csLocationId,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'orderId', orderId);
    RealmObjectBase.set(this, 'orderNumber', orderNumber);
    RealmObjectBase.set(this, 'localPath', localPath);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'ackId', ackId);
    RealmObjectBase.set(this, 'capturedAt', capturedAt);
    RealmObjectBase.set(this, 'imageType', imageType);
    RealmObjectBase.set(this, 'picTitle', picTitle);
    RealmObjectBase.set(this, 'isOnlineSync', isOnlineSync);
    RealmObjectBase.set(this, 'csLocationId', csLocationId);
  }

  OrderPicture._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get orderId => RealmObjectBase.get<String>(this, 'orderId') as String;
  @override
  set orderId(String value) => RealmObjectBase.set(this, 'orderId', value);

  @override
  String get orderNumber =>
      RealmObjectBase.get<String>(this, 'orderNumber') as String;
  @override
  set orderNumber(String value) =>
      RealmObjectBase.set(this, 'orderNumber', value);

  @override
  String? get localPath =>
      RealmObjectBase.get<String>(this, 'localPath') as String?;
  @override
  set localPath(String? value) => RealmObjectBase.set(this, 'localPath', value);

  @override
  String? get url => RealmObjectBase.get<String>(this, 'url') as String?;
  @override
  set url(String? value) => RealmObjectBase.set(this, 'url', value);

  @override
  String? get ackId => RealmObjectBase.get<String>(this, 'ackId') as String?;
  @override
  set ackId(String? value) => RealmObjectBase.set(this, 'ackId', value);

  @override
  String? get capturedAt =>
      RealmObjectBase.get<String>(this, 'capturedAt') as String?;
  @override
  set capturedAt(String? value) =>
      RealmObjectBase.set(this, 'capturedAt', value);

  @override
  String? get imageType =>
      RealmObjectBase.get<String>(this, 'imageType') as String?;
  @override
  set imageType(String? value) => RealmObjectBase.set(this, 'imageType', value);

  @override
  String? get picTitle =>
      RealmObjectBase.get<String>(this, 'picTitle') as String?;
  @override
  set picTitle(String? value) => RealmObjectBase.set(this, 'picTitle', value);

  @override
  bool get isOnlineSync =>
      RealmObjectBase.get<bool>(this, 'isOnlineSync') as bool;
  @override
  set isOnlineSync(bool value) =>
      RealmObjectBase.set(this, 'isOnlineSync', value);

  @override
  String? get csLocationId =>
      RealmObjectBase.get<String>(this, 'csLocationId') as String?;
  @override
  set csLocationId(String? value) =>
      RealmObjectBase.set(this, 'csLocationId', value);

  @override
  Stream<RealmObjectChanges<OrderPicture>> get changes =>
      RealmObjectBase.getChanges<OrderPicture>(this);

  @override
  OrderPicture freeze() => RealmObjectBase.freezeObject<OrderPicture>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OrderPicture._);
    return const SchemaObject(
        ObjectType.realmObject, OrderPicture, 'OrderPicture', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('orderId', RealmPropertyType.string),
      SchemaProperty('orderNumber', RealmPropertyType.string),
      SchemaProperty('localPath', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('ackId', RealmPropertyType.string, optional: true),
      SchemaProperty('capturedAt', RealmPropertyType.string, optional: true),
      SchemaProperty('imageType', RealmPropertyType.string, optional: true),
      SchemaProperty('picTitle', RealmPropertyType.string, optional: true),
      SchemaProperty('isOnlineSync', RealmPropertyType.bool),
      SchemaProperty('csLocationId', RealmPropertyType.string, optional: true),
    ]);
  }
}

class PicturesQueue extends $PicturesQueue
    with RealmEntity, RealmObjectBase, RealmObject {
  PicturesQueue({
    Iterable<OrderPicture> queue = const [],
  }) {
    RealmObjectBase.set<RealmList<OrderPicture>>(
        this, 'queue', RealmList<OrderPicture>(queue));
  }

  PicturesQueue._();

  @override
  RealmList<OrderPicture> get queue =>
      RealmObjectBase.get<OrderPicture>(this, 'queue')
          as RealmList<OrderPicture>;
  @override
  set queue(covariant RealmList<OrderPicture> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<PicturesQueue>> get changes =>
      RealmObjectBase.getChanges<PicturesQueue>(this);

  @override
  PicturesQueue freeze() => RealmObjectBase.freezeObject<PicturesQueue>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PicturesQueue._);
    return const SchemaObject(
        ObjectType.realmObject, PicturesQueue, 'PicturesQueue', [
      SchemaProperty('queue', RealmPropertyType.object,
          linkTarget: 'OrderPicture', collectionType: RealmCollectionType.list),
    ]);
  }
}
