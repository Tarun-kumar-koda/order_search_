// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDetails _$ItemDetailsFromJson(Map<String, dynamic> json) => ItemDetails(
      itemId: json['id'] as String?,
      customerOrderNumber: json['customer_order_number'] as String?,
      itemQuantity: json['item_quantity'] as int?,
      itemWeight: json['item_weight'] as int?,
      itemName: json['item_name'] as String?,
      itemStatus: json['item_status'] as String?,
      itemsSerialNumber: json['item_serial_number'] as String?,
      itemModel: json['item_model'] as String?,
      isChecked: json['is_checked'] as bool?,
      warehouseName: json['current_wh_id'] as String?,
      itemWhDock: json['wh_dock'] as String?,
    );

Map<String, dynamic> _$ItemDetailsToJson(ItemDetails instance) =>
    <String, dynamic>{
      'id': instance.itemId,
      'customer_order_number': instance.customerOrderNumber,
      'item_quantity': instance.itemQuantity,
      'item_weight': instance.itemWeight,
      'item_name': instance.itemName,
      'item_status': instance.itemStatus,
      'item_serial_number': instance.itemsSerialNumber,
      'item_model': instance.itemModel,
      'is_checked': instance.isChecked,
      'current_wh_id': instance.warehouseName,
      'wh_dock': instance.itemWhDock,
    };
