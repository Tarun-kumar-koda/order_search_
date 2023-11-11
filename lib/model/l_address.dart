import 'package:json_annotation/json_annotation.dart';

part 'l_address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address{

  @JsonKey(name: "id")
  String? id;

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

  @JsonKey(name: "coordinates")
  List<double>? coordinates;

  Address({this.id,this.addressLine1,this.addressLine2,this.zipCode,this.city,this.state,this.country,this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}



