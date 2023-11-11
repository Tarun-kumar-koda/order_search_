// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetails _$ContactDetailsFromJson(Map<String, dynamic> json) =>
    ContactDetails(
      contactPhoneNumber2: json['contact_phone_number_2'] as String?,
      contactPhoneNumber1: json['contact_phone_number_1'] as String?,
      contactName: json['contact_name'] as String?,
      contactEmail: json['contact_email'] as String?,
    );

Map<String, dynamic> _$ContactDetailsToJson(ContactDetails instance) =>
    <String, dynamic>{
      'contact_phone_number_1': instance.contactPhoneNumber1,
      'contact_phone_number_2': instance.contactPhoneNumber2,
      'contact_email': instance.contactEmail,
      'contact_name': instance.contactName,
    };
