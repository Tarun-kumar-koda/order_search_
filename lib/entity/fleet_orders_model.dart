import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'orders_model.dart';
part 'fleet_orders_model.g.dart';


@JsonSerializable(explicitToJson: true)
class FleetOrdersModel{

  @JsonKey(name: "order_model_list")
  List<OrdersModel>? orderModelList = [];

  @JsonKey(name: "id")
  String? id ;

  FleetOrdersModel({this.orderModelList,this.id});

  factory FleetOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$FleetOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$FleetOrdersModelToJson(this);

}
