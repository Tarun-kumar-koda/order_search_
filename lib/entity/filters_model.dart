import 'package:json_annotation/json_annotation.dart';

part 'filters_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FiltersValues {

  @JsonKey(name: "id")
  String? filterId;

  @JsonKey(name: "org_id")
  String? filterOrgId;

  @JsonKey(name: "default_filter")
  String? defaultFilter;

  @JsonKey(name: "filter_list_id")
  List<String>? filterListId;

  @JsonKey(name: "filter_list_name")
  List<String>? filterListName;

  FiltersValues(this.filterId,this.filterOrgId,this.defaultFilter,this.filterListId,this.filterListName);

  factory FiltersValues.fromJson(Map<String, dynamic> json) =>
      _$FiltersValuesFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersValuesToJson(this);


}