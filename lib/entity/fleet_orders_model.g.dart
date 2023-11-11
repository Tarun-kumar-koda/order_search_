// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fleet_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FleetOrdersModel _$FleetOrdersModelFromJson(Map<String, dynamic> json) =>
    FleetOrdersModel(
      orderModelList: (json['order_model_list'] as List<dynamic>?)
          ?.map((e) => OrdersModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$FleetOrdersModelToJson(FleetOrdersModel instance) =>
    <String, dynamic>{
      'order_model_list':
          instance.orderModelList?.map((e) => e.toJson()).toList(),
      'id': instance.id,
    };
