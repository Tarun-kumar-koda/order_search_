import 'package:json_annotation/json_annotation.dart';

import '../constant/db_constant.dart';
part 'ware_house_comments.g.dart';

@JsonSerializable(explicitToJson: true)
class WareHouseComments {
  // @JsonKey(name: "created_at")
  // DateTime? pictureCreateAt;

  @JsonKey(name: "comment")
  String? comment;

  @JsonKey(name: "created_at")
  String? createdAt;

  WareHouseComments({
    this.comment,
    this.createdAt,
  });

  factory WareHouseComments.fromJson(Map<String, dynamic> json) =>
      _$WareHouseCommentsFromJson(json);

  Map<String, dynamic> toJson() => _$WareHouseCommentsToJson(this);
}
