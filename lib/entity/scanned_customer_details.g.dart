// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_customer_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannedCustomerDetails _$ScannedCustomerDetailsFromJson(
        Map<String, dynamic> json) =>
    ScannedCustomerDetails(
      accountName: json['account_name'] as String?,
      companyName: json['company_name'] as String?,
      customerID: json['customer_id'] as String?,
      customerFirstName: json['customer_first_name'] as String?,
      customerLastName: json['customer_last_name'] as String?,
      customerPhone1: json['customer_phone_one'] as String?,
      customerPhone2: json['customer_phone_two'] as String?,
      customerEmail: json['customer_email'] as String?,
      customerCity: json['customer_city'] as String?,
      customerState: json['customer_state'] as String?,
      customerCountry: json['customer_country'] as String?,
      customerZipCode: json['customer_zipcode'] as String?,
      customerAddress1: json['customer_address_line'] as String?,
      customerAddress2: json['customer_address_line_2'] as String?,
      itemDetailsList: (json['item_deatails'] as List<dynamic>?)
          ?.map((e) => ItemDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      wareHouseComments: (json['wh_comments'] as List<dynamic>?)
          ?.map((e) => WareHouseComments.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      billingNumber: json['billing_number'] as String?,
      hawb: json['hawb'] as String?,
      levelOfService: json['level_of_service'] as String?,
      mawb: json['mawb'] as String?,
      orderType: json['order_type'] as String?,
      orderWeight: (json['order_weight'] as num?)?.toDouble(),
      palletCount: json['pallets'] as int?,
      wareHouseDock: json['wh_dock'] as String?,
      orderNumber: json['customer_order_number'] as String?,
      truckNumber: json['truck_number'] as String?,
      doorNumber: json['door_number'] as String?,
    );

Map<String, dynamic> _$ScannedCustomerDetailsToJson(
        ScannedCustomerDetails instance) =>
    <String, dynamic>{
      'account_name': instance.accountName,
      'company_name': instance.companyName,
      'customer_id': instance.customerID,
      'customer_first_name': instance.customerFirstName,
      'customer_last_name': instance.customerLastName,
      'customer_phone_one': instance.customerPhone1,
      'customer_phone_two': instance.customerPhone2,
      'customer_email': instance.customerEmail,
      'customer_city': instance.customerCity,
      'customer_state': instance.customerState,
      'customer_country': instance.customerCountry,
      'customer_zipcode': instance.customerZipCode,
      'customer_address_line': instance.customerAddress1,
      'customer_address_line_2': instance.customerAddress2,
      'status': instance.status,
      'wh_dock': instance.wareHouseDock,
      'truck_number': instance.truckNumber,
      'door_number': instance.doorNumber,
      'hawb': instance.hawb,
      'mawb': instance.mawb,
      'order_weight': instance.orderWeight,
      'pallets': instance.palletCount,
      'order_type': instance.orderType,
      'level_of_service': instance.levelOfService,
      'billing_number': instance.billingNumber,
      'customer_order_number': instance.orderNumber,
      'item_deatails':
          instance.itemDetailsList?.map((e) => e.toJson()).toList(),
      'wh_comments':
          instance.wareHouseComments?.map((e) => e.toJson()).toList(),
    };
