// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      url: json['url'] as String?,
      isEditable: json['is_editable'] as bool?,
      isMandatory: json['mandatory'] as bool?,
      picCode: json['pic_code'] as String?,
      picTitle: json['pic_title'] as String?,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'is_editable': instance.isEditable,
      'pic_title': instance.picTitle,
      'pic_code': instance.picCode,
      'mandatory': instance.isMandatory,
    };
