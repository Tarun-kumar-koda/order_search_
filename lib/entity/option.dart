import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable(explicitToJson: true)
class Option {

  @JsonKey(name: "option_id")
  String? optionId;

  @JsonKey(name: "opt_order")
  int? optOrder;

  @JsonKey(name: "opt_value")
  int? optValue;

  @JsonKey(name: "question_id")
  String? questionId;

  Option({this.optionId,this.questionId,this.optOrder,this.optValue});

  factory Option.fromJson(Map<String, dynamic> json) =>
      _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);

}