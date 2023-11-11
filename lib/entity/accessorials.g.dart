// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accessorials.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accessorial _$AccessorialFromJson(Map<String, dynamic> json) => Accessorial(
      orgId: json['org_id'] as String?,
      accountId: json['account_id'] as String?,
      orderId: json['order_id'] as String?,
      label: json['label'] as String?,
      accessorialCode: json['accessorial_code'] as String?,
      accessorialKey: json['accessorial_key'] as String?,
      accessorialType: json['accessorial_type'] as String?,
      accessorialValue: json['accessorial_value'] as String?,
      inputType: json['input_type'] as String?,
      isAddedFromAccount: json['is_added_from_account'] as bool?,
      isCompleted: json['is_completed'] as String?,
      isOptedByDriver: json['is_opted_by_driver'] as bool?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$AccessorialToJson(Accessorial instance) =>
    <String, dynamic>{
      'org_id': instance.orgId,
      'account_id': instance.accountId,
      'accessorial_code': instance.accessorialCode,
      'accessorial_key': instance.accessorialKey,
      'order_id': instance.orderId,
      'accessorial_value': instance.accessorialValue,
      'input_type': instance.inputType,
      'label': instance.label,
      'role': instance.role,
      'is_completed': instance.isCompleted,
      'is_added_from_account': instance.isAddedFromAccount,
      'is_opted_by_driver': instance.isOptedByDriver,
      'accessorial_type': instance.accessorialType,
    };
