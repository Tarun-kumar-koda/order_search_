// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCount _$OrderCountFromJson(Map<String, dynamic> json) => OrderCount(
      newOrdersCount: json['new_orders'] as int?,
      receivedOrdersCount: json['received_orders'] as int?,
      verifiedOrdersCount: json['verified_orders'] as int?,
    );

Map<String, dynamic> _$OrderCountToJson(OrderCount instance) =>
    <String, dynamic>{
      'new_orders': instance.newOrdersCount,
      'received_orders': instance.receivedOrdersCount,
      'verified_orders': instance.verifiedOrdersCount,
    };
