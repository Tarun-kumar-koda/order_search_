// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'l_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String?,
      addressLine1: json['address_line1'] as String?,
      addressLine2: json['address_line2'] as String?,
      zipCode: json['zipcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'address_line1': instance.addressLine1,
      'address_line2': instance.addressLine2,
      'zipcode': instance.zipCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'coordinates': instance.coordinates,
    };
