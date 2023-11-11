// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersModel _$OrdersModelFromJson(Map<String, dynamic> json) => OrdersModel(
      accountName: json['account_name'] as String?,
      orderNumber: json['order_number'] as String?,
      fleetOrderItem: (json['order_items'] as List<dynamic>?)
          ?.map((e) => FleetOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      warehouseComments: (json['wh_comments'] as List<dynamic>?)
          ?.map((e) => WareHouseComments.fromJson(e as Map<String, dynamic>))
          .toList(),
      warehouseName: json['current_wh_id'] as String?,
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
      status: json['status'] as String?,
      isVerified: json['is_verified'] as bool?,
      syncStatus: json['sync_status'] as int?,
      isOrderChecked: json['is_order_checked'] as bool?,
      wareHouseDock: json['wh_dock'] as String?,
      palletCount: json['pallets'] as int?,
      orderWeight: json['order_weight'] as int?,
      truckNumber: json['truck_number'] as String?,
      doorNumber: json['door_number'] as String?,
      orderType: json['order_type'] as String?,
      mawb: json['mawb'] as String?,
      levelOfService: json['level_of_service'] as String?,
      hawb: json['hawb'] as String?,
      billingNumber: json['billing_number'] as String?,
      companyName: json['company_name'] as String?,
      isOrderMoved: json['is_order_moved'] as bool?,
      makeOrderToException: json['make_order_to_exception'] as bool?,
    );

Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
    <String, dynamic>{
      'order_number': instance.orderNumber,
      'order_items': instance.fleetOrderItem?.map((e) => e.toJson()).toList(),
      'wh_comments':
          instance.warehouseComments?.map((e) => e.toJson()).toList(),
      'current_wh_id': instance.warehouseName,
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
      'status': instance.status,
      'customer_address_line_2': instance.customerAddress2,
      'wh_dock': instance.wareHouseDock,
      'hawb': instance.hawb,
      'mawb': instance.mawb,
      'truck_number': instance.truckNumber,
      'door_number': instance.doorNumber,
      'order_weight': instance.orderWeight,
      'pallets': instance.palletCount,
      'order_type': instance.orderType,
      'level_of_service': instance.levelOfService,
      'billing_number': instance.billingNumber,
      'is_verified': instance.isVerified,
      'sync_status': instance.syncStatus,
      'is_order_checked': instance.isOrderChecked,
      'is_order_moved': instance.isOrderMoved,
      'make_order_to_exception': instance.makeOrderToException,
    };
