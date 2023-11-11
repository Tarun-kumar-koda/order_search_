import 'package:json_annotation/json_annotation.dart';

part 'stop_account.g.dart';

@JsonSerializable(explicitToJson: true)
class StopAccount {

  @JsonKey(name: "account_id")
  String? accountId;

  @JsonKey(name: "order_id")
  String? orderId;

  StopAccount({this.orderId,this.accountId});

  factory StopAccount.fromJson(Map<String, dynamic> json) =>
      _$StopAccountFromJson(json);

  Map<String, dynamic> toJson() => _$StopAccountToJson(this);

}