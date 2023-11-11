// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopAccount _$StopAccountFromJson(Map<String, dynamic> json) => StopAccount(
      orderId: json['order_id'] as String?,
      accountId: json['account_id'] as String?,
    );

Map<String, dynamic> _$StopAccountToJson(StopAccount instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'order_id': instance.orderId,
    };
