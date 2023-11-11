// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      customerComments: json['customer_comments'] as String?,
      driverNotes: json['driver_notes'] as String?,
      orderId: json['order_id'] as String?,
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'order_id': instance.orderId,
      'driver_notes': instance.driverNotes,
      'customer_comments': instance.customerComments,
    };
