// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      accessToken: json['access_token'] as String?,
      createdAt: (json['created_at'] as num?)?.toDouble(),
      userId: json['user_id'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toDouble(),
      refreshToken: json['refresh_token'] as String?,
      scopes:
          (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tokenType: json['token_type'] as String?,
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'created_at': instance.createdAt,
      'scopes': instance.scopes,
      'user_id': instance.userId,
    };
