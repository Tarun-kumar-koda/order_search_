// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_responce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentResp _$ParentRespFromJson(Map<String, dynamic> json) => ParentResp(
      scannedCustomerDetails: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ScannedCustomerDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      error:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ParentRespToJson(ParentResp instance) =>
    <String, dynamic>{
      'items': instance.scannedCustomerDetails?.map((e) => e.toJson()).toList(),
      'errors': instance.error,
    };
