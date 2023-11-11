// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOrderItem _$FleetOrderItemFromJson(Map<String, dynamic> json) =>
    FleetOrderItem(
      itemId: json['item_id'] as String?,
      itemName: json['item_name'] as String?,
      orderNumber: json['order_number'] as String?,
      isChecked: json['is_checked'] as bool?,
      itemModel: json['item_model'] as String?,
      warehouseName: json['current_wh_id'] as String?,
      itemsSerialNumber: json['item_serial_number'] as String?,
      itemQuantity: json['item_quantity'] as int?,
      isScanned: json['is_scanned'] as bool?,
      itemStatus: json['item_status'] as String?,
      itemWhDock: json['wh_dock'] as String?,
    )..itemWeight = json['item_weight'] as int?;

Map<String, dynamic> _$FleetOrderItemToJson(FleetOrderItem instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'item_name': instance.itemName,
      'order_number': instance.orderNumber,
      'is_checked': instance.isChecked,
      'current_wh_id': instance.warehouseName,
      'item_model': instance.itemModel,
      'item_quantity': instance.itemQuantity,
      'item_weight': instance.itemWeight,
      'item_status': instance.itemStatus,
      'item_serial_number': instance.itemsSerialNumber,
      'is_scanned': instance.isScanned,
      'wh_dock': instance.itemWhDock,
    };
