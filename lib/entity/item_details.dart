
import 'package:json_annotation/json_annotation.dart';
import '../constant/db_constant.dart';

part 'item_details.g.dart';

@JsonSerializable(explicitToJson: true)

class ItemDetails {

  @JsonKey(name: "id")
  String? itemId;

  @JsonKey(name: "customer_order_number")
  String? customerOrderNumber;

  @JsonKey(name: "item_quantity")
  int? itemQuantity;

  @JsonKey(name: "item_weight")
  int? itemWeight;

  @JsonKey(name: "item_name")
  String? itemName;

  @JsonKey(name: "item_status")
  String? itemStatus;

  @JsonKey(name: "item_serial_number")
  String? itemsSerialNumber;

  @JsonKey(name: "item_model")
  String? itemModel;

  @JsonKey(name: "is_checked")
  bool? isChecked;

  @JsonKey(name: "current_wh_id")
  String? warehouseName;

  @JsonKey(name: "wh_dock")
  String? itemWhDock;


  ItemDetails({this.itemId,this.customerOrderNumber,this.itemQuantity,this.itemWeight,
    this.itemName,this.itemStatus,this.itemsSerialNumber,this.itemModel,this.isChecked,this.warehouseName,this.itemWhDock});

  factory ItemDetails.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailsToJson(this);

}