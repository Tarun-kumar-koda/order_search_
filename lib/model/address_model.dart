import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AddressModel {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "latitude")
  double? latitude;

  @JsonKey(name: "longitude")
  double? longitude;

  @JsonKey(name: "address_line1")
  String? addressLine1;

  @JsonKey(name: "address_line2")
  String? addressLine2;

  @JsonKey(name: "zipcode")
  String? zipCode;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "country")
  String? country;

  @JsonKey(name: "phone_no")
  String? phoneNo;

  @JsonKey(name: "coordinates")
  List<double>? coordinates;

  AddressModel({this.id,this.latitude,this.longitude,this.addressLine1,this.country,
    this.zipCode,this.state,this.city,this.addressLine2,this.coordinates,this.phoneNo});

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

}