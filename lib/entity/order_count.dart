
import 'package:json_annotation/json_annotation.dart';
part 'order_count.g.dart';

@JsonSerializable(explicitToJson: true)

class OrderCount{

  @JsonKey(name: "new_orders")
  int? newOrdersCount;

  @JsonKey(name: "received_orders")
  int? receivedOrdersCount;

  @JsonKey(name: "verified_orders")
  int? verifiedOrdersCount;

  OrderCount({this.newOrdersCount,this.receivedOrdersCount,this.verifiedOrdersCount});

  factory OrderCount.fromJson(Map<String, dynamic> json) =>
      _$OrderCountFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCountToJson(this);



}