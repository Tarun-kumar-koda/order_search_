// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiltersValues _$FiltersValuesFromJson(Map<String, dynamic> json) =>
    FiltersValues(
      json['id'] as String?,
      json['org_id'] as String?,
      json['default_filter'] as String?,
      (json['filter_list_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      (json['filter_list_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FiltersValuesToJson(FiltersValues instance) =>
    <String, dynamic>{
      'id': instance.filterId,
      'org_id': instance.filterOrgId,
      'default_filter': instance.defaultFilter,
      'filter_list_id': instance.filterListId,
      'filter_list_name': instance.filterListName,
    };
