
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/entity/scanner_order_item.dart';

part 'scanner_details.g.dart';


@JsonSerializable(explicitToJson: true)
class ScannerOrderModel{

  @JsonKey(name: "scan_order_number")
  String? scanOrderNumber;

  @JsonKey(name: "scan_order_items")
  List<ScannerOrderItems>? scanOrderItems;

  @JsonKey(name: "current_wh_id")
  String? warehouseName;

  ScannerOrderModel({this.scanOrderNumber,this.scanOrderItems, this.warehouseName});

  factory ScannerOrderModel.fromJson(Map<String, dynamic> json) =>
     _$ScannerOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScannerOrderModelToJson(this);

}
