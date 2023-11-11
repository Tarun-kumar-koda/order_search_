import 'package:json_annotation/json_annotation.dart';
import 'filters_model.dart';

part 'parent_filters.g.dart';

@JsonSerializable(explicitToJson: true)


class ParentFilter {

  @JsonKey(name:"filters")
  List<FiltersValues>? filtersValues = [];

  ParentFilter({this.filtersValues});

  factory ParentFilter.fromJson(Map<String, dynamic> json) =>
      _$ParentFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ParentFilterToJson(this);

}
