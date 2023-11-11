import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/model/address_model.dart';

part 'location_details.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationDetails {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "l_type")
  String? type;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "l_address")
  AddressModel? address;

  @JsonKey(name: "timeZoneId")
  String? timeZoneId;

  @JsonKey(name: "timeZoneName")
  String? timeZoneName;

  LocationDetails({this.id,this.address,this.name,this.email,this.type,this.phone,this.timeZoneId,this.timeZoneName});

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      _$LocationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDetailsToJson(this);

}