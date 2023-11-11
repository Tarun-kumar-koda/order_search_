import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {

  @JsonKey(name: "url")
  String? url;

  @JsonKey(name: "is_editable")
  bool? isEditable;

  @JsonKey(name: "pic_title")
  String? picTitle;

  @JsonKey(name: "pic_code")
  String? picCode;

  @JsonKey(name: "mandatory")
  bool? isMandatory;


  ImageModel({this.url,this.isEditable,this.isMandatory,this.picCode,this.picTitle});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

}