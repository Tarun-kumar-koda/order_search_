import 'package:json_annotation/json_annotation.dart';


part 'scanner_order_item.g.dart';


@JsonSerializable(explicitToJson: true)
class ScannerOrderItems{

  @JsonKey(name: "scan_item_id")
  String? scanItemId;
  @JsonKey(name: "scan_item_name")
  String? scanItemName;
  @JsonKey(name: "scan_order_id")
  String? scanOrderId;
  @JsonKey(name: "scan_is_verified")
  bool? scanIsVerified;
  @JsonKey(name: "scan_current_wh_name")
  String? scanWarehouseName;

  ScannerOrderItems({this.scanItemId,this.scanItemName,this.scanOrderId,this.scanIsVerified, this.scanWarehouseName});

  factory ScannerOrderItems.fromJson(Map<String, dynamic> json) =>
      _$ScannerOrderItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ScannerOrderItemsToJson(this);

}