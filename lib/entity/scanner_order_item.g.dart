// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannerOrderItems _$ScannerOrderItemsFromJson(Map<String, dynamic> json) =>
    ScannerOrderItems(
      scanItemId: json['scan_item_id'] as String?,
      scanItemName: json['scan_item_name'] as String?,
      scanOrderId: json['scan_order_id'] as String?,
      scanIsVerified: json['scan_is_verified'] as bool?,
      scanWarehouseName: json['scan_current_wh_name'] as String?,
    );

Map<String, dynamic> _$ScannerOrderItemsToJson(ScannerOrderItems instance) =>
    <String, dynamic>{
      'scan_item_id': instance.scanItemId,
      'scan_item_name': instance.scanItemName,
      'scan_order_id': instance.scanOrderId,
      'scan_is_verified': instance.scanIsVerified,
      'scan_current_wh_name': instance.scanWarehouseName,
    };
