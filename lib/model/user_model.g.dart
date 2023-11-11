// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['id'] as String?,
      createdAt: json['created_at'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      email: json['email'] as String?,
      designation: json['designation'] as String?,
      employeeCode: json['employee_code'] as String?,
      firstName: json['first_name'] as String?,
      isSignIn: json['sign_in'] as bool?,
      lastName: json['last_name'] as String?,
      middleName: json['middle_name'] as String?,
      orgIds: (json['organization_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      workLocation: json['work_location'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      officeAddress: json['office_address'] == null
          ? null
          : AddressModel.fromJson(
              json['office_address'] as Map<String, dynamic>),
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'middle_name': instance.middleName,
      'email': instance.email,
      'mobile_number': instance.mobileNumber,
      'sign_in': instance.isSignIn,
      'designation': instance.designation,
      'work_location': instance.workLocation,
      'employee_code': instance.employeeCode,
      'created_at': instance.createdAt,
      'organization_ids': instance.orgIds,
      'image': instance.image?.toJson(),
      'office_address': instance.officeAddress?.toJson(),
      'address': instance.address?.toJson(),
      'roles': instance.roles,
    };
