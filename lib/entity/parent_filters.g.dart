// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_filters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentFilter _$ParentFilterFromJson(Map<String, dynamic> json) => ParentFilter(
      filtersValues: (json['filters'] as List<dynamic>?)
          ?.map((e) => FiltersValues.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParentFilterToJson(ParentFilter instance) =>
    <String, dynamic>{
      'filters': instance.filtersValues?.map((e) => e.toJson()).toList(),
    };
