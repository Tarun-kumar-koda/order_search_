import 'package:json_annotation/json_annotation.dart';

part 'comments.g.dart';

@JsonSerializable(explicitToJson: true)
class Comments {

  @JsonKey(name: "order_id")
  String? orderId;

  @JsonKey(name: "driver_notes")
  String? driverNotes;

  @JsonKey(name: "customer_comments")
  String? customerComments;

  Comments({this.customerComments,this.driverNotes,this.orderId});

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);

}