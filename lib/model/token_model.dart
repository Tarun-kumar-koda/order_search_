import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TokenModel {

  @JsonKey(name: "access_token")
  String? accessToken;

  @JsonKey(name: "token_type")
  String? tokenType;

  @JsonKey(name: "expires_in")
  double? expiresIn;

  @JsonKey(name: "refresh_token")
  String? refreshToken;

  @JsonKey(name: "created_at")
  double? createdAt;

  @JsonKey(name: "scopes")
  List<String>? scopes;

  @JsonKey(name: "user_id")
  String? userId;

  TokenModel({this.accessToken,this.createdAt,this.userId,this.expiresIn,
    this.refreshToken,this.scopes,this.tokenType});


  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

}