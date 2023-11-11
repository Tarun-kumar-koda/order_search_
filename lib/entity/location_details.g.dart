// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDetails _$LocationDetailsFromJson(Map<String, dynamic> json) =>
    LocationDetails(
      id: json['id'] as String?,
      address: json['l_address'] == null
          ? null
          : AddressModel.fromJson(json['l_address'] as Map<String, dynamic>),
      name: json['name'] as String?,
      email: json['email'] as String?,
      type: json['l_type'] as String?,
      phone: json['phone'] as String?,
      timeZoneId: json['timeZoneId'] as String?,
      timeZoneName: json['timeZoneName'] as String?,
    );

Map<String, dynamic> _$LocationDetailsToJson(LocationDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'l_type': instance.type,
      'phone': instance.phone,
      'name': instance.name,
      'l_address': instance.address?.toJson(),
      'timeZoneId': instance.timeZoneId,
      'timeZoneName': instance.timeZoneName,
    };
