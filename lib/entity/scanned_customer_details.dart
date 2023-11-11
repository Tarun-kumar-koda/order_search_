import 'package:json_annotation/json_annotation.dart';
import 'package:order_search/entity/ware_house_comments.dart';
import 'item_details.dart';

part 'scanned_customer_details.g.dart';

@JsonSerializable(explicitToJson: true)
class ScannedCustomerDetails {
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

  @JsonKey(name: "customer_address_line_2")
  String? customerAddress2;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "wh_dock")
  String? wareHouseDock;

  @JsonKey(name: "truck_number")
  String? truckNumber;

  @JsonKey(name: "door_number")
  String? doorNumber;

  @JsonKey(name: "hawb")
  String? hawb;

  @JsonKey(name: "mawb")
  String? mawb;

  @JsonKey(name: "order_weight")
  double? orderWeight;

  @JsonKey(name: "pallets")
  int? palletCount;

  @JsonKey(name: "order_type")
  String? orderType;

  @JsonKey(name: "level_of_service")
  String? levelOfService;

  @JsonKey(name: "billing_number")
  String? billingNumber;

  @JsonKey(name: "customer_order_number")
  String? orderNumber;

  @JsonKey(name: "item_deatails")
  List<ItemDetails>? itemDetailsList;

  @JsonKey(name: "wh_comments")
  List<WareHouseComments>? wareHouseComments;

  ScannedCustomerDetails(
      {this.accountName,
      this.companyName,
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
      this.itemDetailsList,
      this.wareHouseComments,
      this.status,
      this.billingNumber,
      this.hawb,
      this.levelOfService,
      this.mawb,
      this.orderType,
      this.orderWeight,
      this.palletCount,
      this.wareHouseDock,
      this.orderNumber,
      this.truckNumber,
      this.doorNumber});

  factory ScannedCustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$ScannedCustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ScannedCustomerDetailsToJson(this);
}
