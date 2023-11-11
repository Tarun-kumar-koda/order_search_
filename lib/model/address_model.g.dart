// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      addressLine1: json['address_line1'] as String?,
      country: json['country'] as String?,
      zipCode: json['zipcode'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      addressLine2: json['address_line2'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      phoneNo: json['phone_no'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address_line1': instance.addressLine1,
      'address_line2': instance.addressLine2,
      'zipcode': instance.zipCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'phone_no': instance.phoneNo,
      'coordinates': instance.coordinates,
    };
