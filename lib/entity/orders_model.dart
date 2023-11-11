import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../constant/db_constant.dart';
import 'fleet_order_item.dart';
import 'ware_house_comments.dart';
part 'orders_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrdersModel {
  @JsonKey(name: "order_number")
  String? orderNumber;

  @JsonKey(name: "order_items")
  List<FleetOrderItem>? fleetOrderItem;

  @JsonKey(name: "wh_comments")
  List<WareHouseComments>? warehouseComments;

  @JsonKey(name: "current_wh_id")
  String? warehouseName;

  @JsonKey(name: "account_name")
  String? accountName;

  @JsonKey(name: "company_name")
  String? companyName;

  @JsonKey(name: "customer_id")
  String? customerID;

  @JsonKey(name: "customer_first_name")
  String? customerFirstName;

  @JsonKey(name: "customer_last_name")
  String? customerLastName;

  @JsonKey(name: "customer_phone_one")
  String? customerPhone1;

  @JsonKey(name: "customer_phone_two")
  String? customerPhone2;

  @JsonKey(name: "customer_email")
  String? customerEmail;

  @JsonKey(name: "customer_city")
  String? customerCity;

  @JsonKey(name: "customer_state")
  String? customerState;

  @JsonKey(name: "customer_country")
  String? customerCountry;

  @JsonKey(name: "customer_zipcode")
  String? customerZipCode;

  @JsonKey(name: "customer_address_line")
  String? customerAddress1;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "customer_address_line_2")
  String? customerAddress2;

  @JsonKey(name: "wh_dock")
  String? wareHouseDock;

  @JsonKey(name: "hawb")
  String? hawb;

  @JsonKey(name: "mawb")
  String? mawb;

  @JsonKey(name: "truck_number")
  String? truckNumber;

  @JsonKey(name: "door_number")
  String? doorNumber;

  @JsonKey(name: "order_weight")
  int? orderWeight;

  @JsonKey(name: "pallets")
  int? palletCount;

  @JsonKey(name: "order_type")
  String? orderType;

  @JsonKey(name: "level_of_service")
  String? levelOfService;

  @JsonKey(name: "billing_number")
  String? billingNumber;

  @JsonKey(name: "is_verified")
  bool? isVerified = false;

  @JsonKey(name: "sync_status")
  int? syncStatus;

  @JsonKey(name: "is_order_checked")
  bool? isOrderChecked;

  @JsonKey(name: "is_order_moved")
  bool? isOrderMoved;

  @JsonKey(name: "make_order_to_exception")
  bool? makeOrderToException = false;

  OrdersModel(
      {this.accountName,
      this.orderNumber,
      this.fleetOrderItem,
      this.warehouseComments,
      this.warehouseName,
      this.customerID,
      this.customerFirstName,
      this.customerLastName,
      this.customerPhone1,
      this.customerPhone2,
      this.customerEmail,
      this.customerCity,
      this.customerState,
      this.customerCountry,
      this.customerZipCode,
      this.customerAddress1,
      this.customerAddress2,
      this.status,
      this.isVerified,
      this.syncStatus,
      this.isOrderChecked,
      this.wareHouseDock,
      this.palletCount,
      this.orderWeight,
      this.truckNumber,
      this.doorNumber,
      this.orderType,
      this.mawb,
      this.levelOfService,
      this.hawb,
      this.billingNumber,
      this.companyName,
      this.isOrderMoved,
      this.makeOrderToException});

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);

}
