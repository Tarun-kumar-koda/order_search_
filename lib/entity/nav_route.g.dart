// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavRoute _$NavRouteFromJson(Map<String, dynamic> json) => NavRoute(
      id: json['id'] as String?,
      name: json['r_name'] as String?,
      scheduledStartDate: json['r_scheduled_start_datetime'] == null
          ? null
          : DateTime.parse(json['r_scheduled_start_datetime'] as String),
      scheduledEndDate: json['r_scheduled_end_datetime'] == null
          ? null
          : DateTime.parse(json['r_scheduled_end_datetime'] as String),
      actualStartDate: json['r_actual_start_datetime'] == null
          ? null
          : DateTime.parse(json['r_actual_start_datetime'] as String),
      actualEndDate: json['r_actual_end_datetime'] == null
          ? null
          : DateTime.parse(json['r_actual_end_datetime'] as String),
      routeStatus: json['r_status'] as String? ?? 'ASSIGNED',
      startSyncStatus: json['r_start_sync_status'] as int? ?? 1000,
      completeSyncStatus: json['r_complete_sync_status'] as int? ?? 1000,
      customerOrderIds: (json['customer_order_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastStopAddress: json['last_stop_address'] == null
          ? null
          : AddressModel.fromJson(
              json['last_stop_address'] as Map<String, dynamic>),
      firstStopAddress: json['first_stop_address'] == null
          ? null
          : AddressModel.fromJson(
              json['first_stop_address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NavRouteToJson(NavRoute instance) => <String, dynamic>{
      'id': instance.id,
      'r_name': instance.name,
      'r_scheduled_start_datetime':
          instance.scheduledStartDate?.toIso8601String(),
      'r_scheduled_end_datetime': instance.scheduledEndDate?.toIso8601String(),
      'r_actual_start_datetime': instance.actualStartDate?.toIso8601String(),
      'r_actual_end_datetime': instance.actualEndDate?.toIso8601String(),
      'r_status': instance.routeStatus,
      'r_start_sync_status': instance.startSyncStatus,
      'r_complete_sync_status': instance.completeSyncStatus,
      'customer_order_ids': instance.customerOrderIds,
      'first_stop_address': instance.firstStopAddress?.toJson(),
      'last_stop_address': instance.lastStopAddress?.toJson(),
    };
