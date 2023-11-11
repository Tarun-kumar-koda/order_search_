import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/model/token_model.dart';
import 'package:order_search/model/user_model.dart';

part 'user_authentication.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAuthentication {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "organization_name")
  String? orgId;

  @JsonKey(name: "token")
  TokenModel? tokenModel;

  @JsonKey(name: "user")
  UserModel? userModel;

  UserAuthentication({this.id, this.orgId, this.tokenModel, this.userModel});

  factory UserAuthentication.fromJson(Map<String, dynamic> json) =>
      _$UserAuthenticationFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthenticationToJson(this);

}