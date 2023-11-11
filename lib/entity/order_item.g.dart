// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String?,
      barCodeInfo: json['barcode_info'] as String?,
      billingNumber: json['billing_number'] as String?,
      customerOrderId: json['customer_order_id'] as String?,
      customerOrderNumber: json['customer_order_number'] as String?,
      dropLocationId: json['drop_location_id'] as String?,
      droppedAt: json['dropped_at'] == null
          ? null
          : DateTime.parse(json['dropped_at'] as String),
      dropSyncStatus: json['drop_sync_status'] as int? ?? 1000,
      failedNotes: json['failed_notes'] as String?,
      isChecked: json['isChecked'] as bool?,
      itemModel: json['item_model'] as String?,
      itemName: json['item_name'] as String?,
      itemType: json['item_type'] as String?,
      miscellaneous: json['miscellaneous'] as String?,
      notes: json['notes'] as String?,
      pickedAt: json['picked_at'] == null
          ? null
          : DateTime.parse(json['picked_at'] as String),
      pickUpLocationId: json['pick_up_location_id'] as String?,
      pickUpSyncStatus: json['pick_up_sync_status'] as int? ?? 1000,
      quantity: json['item_quantity'] as int?,
      returnAuthorization: json['return_authorization'] as String?,
      serialNumber: json['serial_number'] as String?,
      serviceIds: (json['service_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'customer_order_id': instance.customerOrderId,
      'customer_order_number': instance.customerOrderNumber,
      'item_type': instance.itemType,
      'item_model': instance.itemModel,
      'item_name': instance.itemName,
      'service_ids': instance.serviceIds,
      'serial_number': instance.serialNumber,
      'miscellaneous': instance.miscellaneous,
      'notes': instance.notes,
      'item_quantity': instance.quantity,
      'failed_notes': instance.failedNotes,
      'pick_up_location_id': instance.pickUpLocationId,
      'picked_at': instance.pickedAt?.toIso8601String(),
      'drop_location_id': instance.dropLocationId,
      'dropped_at': instance.droppedAt?.toIso8601String(),
      'pick_up_sync_status': instance.pickUpSyncStatus,
      'drop_sync_status': instance.dropSyncStatus,
      'return_authorization': instance.returnAuthorization,
      'billing_number': instance.billingNumber,
      'barcode_info': instance.barCodeInfo,
      'isChecked': instance.isChecked,
    };
