
import 'scanned_customer_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent_responce.g.dart';


@JsonSerializable(explicitToJson: true)

class ParentResp {

  @JsonKey(name: "items")
  List<ScannedCustomerDetails>? scannedCustomerDetails = [];

  @JsonKey(name: "errors")
  List<String>? error = [];

  ParentResp({this.scannedCustomerDetails, this.error});

  factory ParentResp.fromJson(Map<String, dynamic> json) =>
      _$ParentRespFromJson(json);

  Map<String, dynamic> toJson() => _$ParentRespToJson(this);


}