import 'package:json_annotation/json_annotation.dart';

part 'accessorials.g.dart';

@JsonSerializable(explicitToJson: true)
class Accessorial {

  @JsonKey(name: "org_id")
  String? orgId;

  @JsonKey(name: "account_id")
  String? accountId;

  @JsonKey(name: "accessorial_code")
  String? accessorialCode;

  @JsonKey(name: "accessorial_key")
  String? accessorialKey;

  @JsonKey(name: "order_id")
  String? orderId;

  @JsonKey(name: "accessorial_value")
  String? accessorialValue;

  @JsonKey(name: "input_type")
  String? inputType;

  @JsonKey(name: "label")
  String? label;

  @JsonKey(name: "role")
  String? role;

  @JsonKey(name: "is_completed")
  String? isCompleted;

  @JsonKey(name: "is_added_from_account")
  bool? isAddedFromAccount;

  @JsonKey(name: "is_opted_by_driver")
  bool? isOptedByDriver;

  @JsonKey(name: "accessorial_type")
  String? accessorialType;

  Accessorial({this.orgId, this.accountId,this.orderId,this.label,this.accessorialCode,
    this.accessorialKey,this.accessorialType,this.accessorialValue,this.inputType,
    this.isAddedFromAccount,this.isCompleted,this.isOptedByDriver,this.role});

  factory Accessorial.fromJson(Map<String, dynamic> json) =>
      _$AccessorialFromJson(json);

  Map<String, dynamic> toJson() => _$AccessorialToJson(this);

}