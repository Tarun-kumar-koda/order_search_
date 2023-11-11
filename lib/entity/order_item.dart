import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/constant/db_constant.dart';

part 'order_item.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderItem {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "customer_order_id")
  String? customerOrderId;

  @JsonKey(name: "customer_order_number")
  String? customerOrderNumber;

  @JsonKey(name: "item_type")
  String? itemType;

  @JsonKey(name: "item_model")
  String? itemModel;

  @JsonKey(name: "item_name")
  String? itemName;

  @JsonKey(name: "service_ids")
  List<String>? serviceIds;

  @JsonKey(name: "serial_number")
  String? serialNumber;

  @JsonKey(name: "miscellaneous")
  String? miscellaneous;

  @JsonKey(name: "notes")
  String? notes;

  @JsonKey(name: "item_quantity")
  int? quantity;

  @JsonKey(name: "failed_notes")
  String? failedNotes;

  @JsonKey(name: "pick_up_location_id")
  String? pickUpLocationId;

  @JsonKey(name: "picked_at")
  DateTime? pickedAt;

  @JsonKey(name: "drop_location_id")
  String? dropLocationId;

  @JsonKey(name: "dropped_at")
  DateTime? droppedAt;

  @JsonKey(name: "pick_up_sync_status", defaultValue: DBConstants.SYNC_STATUS_DEFAULT)
  int? pickUpSyncStatus;

  @JsonKey(name: "drop_sync_status", defaultValue: DBConstants.SYNC_STATUS_DEFAULT)
  int? dropSyncStatus;

  @JsonKey(name: "return_authorization")
  String? returnAuthorization;

  @JsonKey(name: "billing_number")
  String? billingNumber;

  @JsonKey(name: "barcode_info")
  String? barCodeInfo;

  bool? isChecked;

  OrderItem({this.id,this.barCodeInfo,this.billingNumber,this.customerOrderId,
    this.customerOrderNumber,this.dropLocationId,this.droppedAt,this.dropSyncStatus,
    this.failedNotes,this.isChecked,this.itemModel,this.itemName,this.itemType,
    this.miscellaneous,this.notes,this.pickedAt,this.pickUpLocationId,this.pickUpSyncStatus,
    this.quantity,this.returnAuthorization,this.serialNumber,this.serviceIds});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  factory OrderItem.fromDBJson(Map<String, dynamic> params) {
    return OrderItem(
      id: params[DBConstants.id] as String?,
      customerOrderId: params[DBConstants.customer_order_id] as String?,
      customerOrderNumber: params[DBConstants.customer_order_number] as String?,
      itemType: params[DBConstants.item_type] as String?,
      itemModel: params[DBConstants.item_model] as String?,
      itemName: params[DBConstants.item_name] as String?,
//      serviceIds: (params[DBConstants.service_ids] as List<dynamic>?)
//            ?.map((e) => e as String)
//            .toList(),
      serialNumber: params[DBConstants.serial_number] as String?,
      miscellaneous: params[DBConstants.miscellaneous] as String?,
      notes: params[DBConstants.notes] as String?,
      quantity: params[DBConstants.item_quantity] as int?,
      failedNotes: params[DBConstants.failed_notes] as String?,
      pickUpLocationId: params[DBConstants.pick_up_location_id] as String?,
      pickedAt: params[DBConstants.picked_at] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
          params[DBConstants.picked_at] as int),
      dropLocationId: params[DBConstants.drop_location_id] as String?,
      droppedAt: params[DBConstants.dropped_at] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
          params[DBConstants.dropped_at] as int),
      pickUpSyncStatus: params[DBConstants.pick_up_sync_status] as int?,
      dropSyncStatus: params[DBConstants.drop_sync_status] as int?,
      returnAuthorization: params[DBConstants.return_authorization] as String?,
      billingNumber: params[DBConstants.billing_number] as String?,
      barCodeInfo: params[DBConstants.barcode_info] as String?,
    );}

  Map<String, dynamic> toDBJson() {
    return <String, dynamic>{
      DBConstants.id: id,
      DBConstants.customer_order_id: customerOrderId,
      DBConstants.customer_order_number: customerOrderNumber,
      DBConstants.item_type: itemType,
      DBConstants.item_model: itemModel,
      DBConstants.item_name: itemName,
      if(serviceIds != null)
        DBConstants.service_ids: serviceIds?.map((v) => v.toString()).toList(),
      DBConstants.serial_number: serialNumber,
      DBConstants.miscellaneous: miscellaneous,
      DBConstants.notes: notes,
      DBConstants.item_quantity: quantity,
      DBConstants.failed_notes: failedNotes,
      DBConstants.pick_up_location_id: pickUpLocationId,
      DBConstants.picked_at: pickedAt?.millisecondsSinceEpoch,
      DBConstants.drop_location_id: dropLocationId,
      DBConstants.dropped_at: droppedAt?.millisecondsSinceEpoch,
      DBConstants.pick_up_sync_status: pickUpSyncStatus,
      DBConstants.drop_sync_status: dropSyncStatus,
      DBConstants.return_authorization: returnAuthorization,
      DBConstants.billing_number: billingNumber,
      DBConstants.barcode_info: barCodeInfo,
    };
  }

}