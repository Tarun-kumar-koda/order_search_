import 'package:json_annotation/json_annotation.dart';

part 'contact_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ContactDetails {

  @JsonKey(name: "contact_phone_number_1")
  String? contactPhoneNumber1;

  @JsonKey(name: "contact_phone_number_2")
  String? contactPhoneNumber2;

  @JsonKey(name: "contact_email")
  String? contactEmail;

  @JsonKey(name: "contact_name")
  String? contactName;

  ContactDetails({this.contactPhoneNumber2,this.contactPhoneNumber1,this.contactName,this.contactEmail});

  factory ContactDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailsToJson(this);

}