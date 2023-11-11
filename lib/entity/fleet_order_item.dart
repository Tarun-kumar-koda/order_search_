import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


part 'fleet_order_item.g.dart';


@JsonSerializable(explicitToJson: true)
class FleetOrderItem{

  @JsonKey(name: "item_id")
  String? itemId;

  @JsonKey(name: "item_name")
  String? itemName;

  @JsonKey(name: "order_number")
  String? orderNumber;

  @JsonKey(name: "is_checked")
  bool? isChecked;

  @JsonKey(name: "current_wh_id")
  String? warehouseName;

  @JsonKey(name: "item_model")
  String? itemModel;

  @JsonKey(name: "item_quantity")
  int? itemQuantity;

  @JsonKey(name: "item_weight")
  int? itemWeight;

  @JsonKey(name: "item_status")
  String? itemStatus;

  @JsonKey(name: "item_serial_number")
  String? itemsSerialNumber;

  @JsonKey(name: "is_scanned")
  bool? isScanned;

  @JsonKey(name: "wh_dock")
  String? itemWhDock;

  FleetOrderItem({this.itemId,this.itemName,this.orderNumber,this.isChecked,this.itemModel, this.warehouseName,this.itemsSerialNumber,this.itemQuantity,this.isScanned,this.itemStatus,this.itemWhDock});

  factory FleetOrderItem.fromJson(Map<String, dynamic> json) =>
      _$FleetOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$FleetOrderItemToJson(this);

}
