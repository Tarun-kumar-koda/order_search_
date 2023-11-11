// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanner_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannerOrderModel _$ScannerOrderModelFromJson(Map<String, dynamic> json) =>
    ScannerOrderModel(
      scanOrderNumber: json['scan_order_number'] as String?,
      scanOrderItems: (json['scan_order_items'] as List<dynamic>?)
          ?.map((e) => ScannerOrderItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      warehouseName: json['current_wh_id'] as String?,
    );

Map<String, dynamic> _$ScannerOrderModelToJson(ScannerOrderModel instance) =>
    <String, dynamic>{
      'scan_order_number': instance.scanOrderNumber,
      'scan_order_items':
          instance.scanOrderItems?.map((e) => e.toJson()).toList(),
      'current_wh_id': instance.warehouseName,
    };
