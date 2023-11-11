// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthentication _$UserAuthenticationFromJson(Map<String, dynamic> json) =>
    UserAuthentication(
      id: json['id'] as String?,
      orgId: json['organization_name'] as String?,
      tokenModel: json['token'] == null
          ? null
          : TokenModel.fromJson(json['token'] as Map<String, dynamic>),
      userModel: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAuthenticationToJson(UserAuthentication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization_name': instance.orgId,
      'token': instance.tokenModel?.toJson(),
      'user': instance.userModel?.toJson(),
    };
