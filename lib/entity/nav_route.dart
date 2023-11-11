import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/constant/db_constant.dart';
import 'package:order_search/constant/route_constant.dart';
import 'package:order_search/model/address_model.dart';

part 'nav_route.g.dart';

@JsonSerializable(explicitToJson: true)
class NavRoute {

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "r_name")
  String? name;

  @JsonKey(name: "r_scheduled_start_datetime")
  DateTime? scheduledStartDate;

  @JsonKey(name: "r_scheduled_end_datetime")
  DateTime? scheduledEndDate;

  @JsonKey(name: "r_actual_start_datetime")
  DateTime? actualStartDate;

  @JsonKey(name: "r_actual_end_datetime")
  DateTime? actualEndDate;

  @JsonKey(name: "r_status",defaultValue: RouteConstants.STATUS_ASSIGNED)
  String? routeStatus;

  @JsonKey(name: "r_start_sync_status", defaultValue: DBConstants.SYNC_STATUS_DEFAULT)
  int? startSyncStatus;

  @JsonKey(name: "r_complete_sync_status", defaultValue: DBConstants.SYNC_STATUS_DEFAULT)
  int? completeSyncStatus;

  @JsonKey(name: "customer_order_ids")
  List<String>? customerOrderIds;

  @JsonKey(name: "first_stop_address")
  AddressModel? firstStopAddress;

  @JsonKey(name: "last_stop_address")
  AddressModel? lastStopAddress;

  NavRoute({this.id, this.name, this.scheduledStartDate, this.scheduledEndDate, this.actualStartDate,
    this.actualEndDate, this.routeStatus, this.startSyncStatus, this.completeSyncStatus,
    this.customerOrderIds, this.lastStopAddress,this.firstStopAddress});

  factory NavRoute.fromJson(Map<String, dynamic> json) =>
      _$NavRouteFromJson(json);

  Map<String, dynamic> toJson() => _$NavRouteToJson(this);

}