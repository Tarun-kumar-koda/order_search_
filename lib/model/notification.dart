import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "created_at")
  DateTime? createdAt;

  Notification({this.id,this.message,this.title,this.createdAt});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

}