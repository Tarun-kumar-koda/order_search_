import 'package:json_annotation/json_annotation.dart';

import 'address_model.dart';
import 'image_model.dart';

part 'user_model.g.dart';


@JsonSerializable(explicitToJson: true)
class UserModel {

  @JsonKey(name: "id")
  String? userId;

  @JsonKey(name: "first_name")
  String? firstName;

  @JsonKey(name: "last_name")
  String? lastName;

  @JsonKey(name: "middle_name")
  String? middleName;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "mobile_number")
  String? mobileNumber;

  @JsonKey(name: "sign_in")
  bool? isSignIn;

  @JsonKey(name: "designation")
  String? designation;

  @JsonKey(name: "work_location")
  String? workLocation;

  @JsonKey(name: "employee_code")
  String? employeeCode;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "organization_ids")
  List<String>? orgIds;

  @JsonKey(name: "image")
  ImageModel? image;

  @JsonKey(name: "office_address")
  AddressModel? officeAddress;

  @JsonKey(name: "address")
  AddressModel? address;

  @JsonKey(name: "roles")
  List<String>? roles;


  UserModel({this.userId,this.createdAt,this.mobileNumber,this.email,
    this.designation,this.employeeCode,this.firstName,this.isSignIn,this.lastName,
    this.middleName,this.orgIds,this.workLocation,this.address,this.image,this.officeAddress, this.roles});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}