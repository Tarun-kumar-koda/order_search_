import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/model/user_authentication.dart';

part 'authentication_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthenticationResponse {
  @JsonKey(name: "auth_tokens")
  List<UserAuthentication>? userAuthentication;

  AuthenticationResponse({this.userAuthentication});

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);

}