// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      optionId: json['option_id'] as String?,
      questionId: json['question_id'] as String?,
      optOrder: json['opt_order'] as int?,
      optValue: json['opt_value'] as int?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'option_id': instance.optionId,
      'opt_order': instance.optOrder,
      'opt_value': instance.optValue,
      'question_id': instance.questionId,
    };
