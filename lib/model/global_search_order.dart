
class GlobalSearchBaseResponse {
  List<CustomerOrders>? customerOrders;
  GlobalSearchBaseResponse(
      {this.customerOrders});

  GlobalSearchBaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['customer_orders'] != null) {
      customerOrders = <CustomerOrders>[];
      json['customer_orders'].forEach((v) {
        customerOrders!.add(new CustomerOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customerOrders != null) {
      data['customer_orders'] =
          this.customerOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerOrders {
  List<OrderAppointments>? orderAppointments;
  String? navRouteId;
  Order? order;
  CsLocation? csLocation;
  WhLocation? whLocation;
  String? state;
  String? city;
  String? timeZoneId;
  String? timeZoneName;
  String? tzShortForm;
  Origin? origin;
  Origin? destination;

  CustomerOrders(
      {this.orderAppointments,
        this.navRouteId,
        this.order,
        this.csLocation,
        this.whLocation,
        this.state,
        this.city,
        this.timeZoneId,
        this.timeZoneName,
        this.tzShortForm,
        this.origin,
        this.destination});

  CustomerOrders.fromJson(Map<String, dynamic> json) {
    if (json['order_appointments'] != null) {
      orderAppointments = <OrderAppointments>[];
      json['order_appointments'].forEach((v) {
        orderAppointments!.add(new OrderAppointments.fromJson(v));
      });
    }
    navRouteId = json['nav_route_id'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    csLocation = json['cs_location'] != null
        ? new CsLocation.fromJson(json['cs_location'])
        : null;
    whLocation = json['wh_location'] != null
        ? new WhLocation.fromJson(json['wh_location'])
        : null;
    state = json['state'];
    city = json['city'];
    timeZoneId = json['timeZoneId'];
    timeZoneName = json['timeZoneName'];
    tzShortForm = json['tz_short_form'];
    origin =
    json['origin'] != null ? new Origin.fromJson(json['origin']) : null;
    destination = json['destination'] != null
        ? new Origin.fromJson(json['destination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderAppointments != null) {
      data['order_appointments'] =
          this.orderAppointments!.map((v) => v.toJson()).toList();
    }
    data['nav_route_id'] = this.navRouteId;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.csLocation != null) {
      data['cs_location'] = this.csLocation!.toJson();
    }
    if (this.whLocation != null) {
      data['wh_location'] = this.whLocation!.toJson();
    }
    data['state'] = this.state;
    data['city'] = this.city;
    data['timeZoneId'] = this.timeZoneId;
    data['timeZoneName'] = this.timeZoneName;
    data['tz_short_form'] = this.tzShortForm;
    if (this.origin != null) {
      data['origin'] = this.origin!.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination!.toJson();
    }
    return data;
  }
}

class Origin {
  String? id;
  String? name;
  String? lType;
  LAddress? lAddress;
  String? timeZoneId;
  String? timeZoneName;
  String? locationCode;
  String? companyName;
  String? typeOfLoc;
  String? status;
  String? levelOfService;

  Origin(
      {this.id,
        this.name,
        this.lType,
        this.lAddress,
        this.timeZoneId,
        this.timeZoneName,
        this.locationCode,
        this.companyName,
        this.typeOfLoc,
        this.status,
        this.levelOfService});

  Origin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lType = json['l_type'];
    lAddress = json['l_address'] != null
        ? new LAddress.fromJson(json['l_address'])
        : null;
    timeZoneId = json['timeZoneId'];
    timeZoneName = json['timeZoneName'];
    locationCode = json['location_code'];
    companyName = json['company_name'];
    typeOfLoc = json['type_of_loc'];
    status = json['status'];
    levelOfService = json['level_of_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['l_type'] = this.lType;
    if (this.lAddress != null) {
      data['l_address'] = this.lAddress!.toJson();
    }
    data['timeZoneId'] = this.timeZoneId;
    data['timeZoneName'] = this.timeZoneName;
    data['location_code'] = this.locationCode;
    data['company_name'] = this.companyName;
    data['type_of_loc'] = this.typeOfLoc;
    data['status'] = this.status;
    data['level_of_service'] = this.levelOfService;
    return data;
  }
}

class OrderAppointments {
  String? customerOrderId;
  String? startDatetime;
  String? endDatetime;
  String? slotName;
  bool? confirmed;

  OrderAppointments(
      {this.customerOrderId,
        this.startDatetime,
        this.endDatetime,
        this.slotName,
        this.confirmed});

  OrderAppointments.fromJson(Map<String, dynamic> json) {
    customerOrderId = json['customer_order_id'];
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    slotName = json['slot_name'];
    confirmed = json['confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_order_id'] = this.customerOrderId;
    data['start_datetime'] = this.startDatetime;
    data['end_datetime'] = this.endDatetime;
    data['slot_name'] = this.slotName;
    data['confirmed'] = this.confirmed;
    return data;
  }
}

class Order {
  String? id;
  String? customerOrderNumber;
  String? customerFirstName;
  String? customerLastName;
  String? customerPhoneOne;
  String? customerPhoneTwo;
  String? customerEmail;
  String? typeOfOrder;
  String? accountCode;
  String? levelOfService;
  String? whLocationId;
  String? customerAddressLine;
  String? customerAddressLine2;
  String? customerAddressLine3;
  String? customerCity;
  String? customerState;
  String? customerCountry;
  String? customerZipcode;
  String? csLocationId;
  String? status;
  String? relatedOrder;
  String? createdAt;
  bool? locationPartialMatch;
  String? rejectionMessage;
  String? hawb;
  String? mawb;
  String? reference1Type;
  String? reference1;
  String? reference2Type;
  String? reference2;
  String? accountName;
  String? losName;
  String? warehouseCode;
  String? companyName;
  String? localPath;
  bool? isOnlineSync;

  Order(
      {this.id,
        this.customerOrderNumber,
        this.customerFirstName,
        this.customerLastName,
        this.customerPhoneOne,
        this.customerPhoneTwo,
        this.customerEmail,
        this.typeOfOrder,
        this.accountCode,
        this.levelOfService,
        this.whLocationId,
        this.customerAddressLine,
        this.customerAddressLine2,
        this.customerAddressLine3,
        this.customerCity,
        this.customerState,
        this.customerCountry,
        this.customerZipcode,
        this.csLocationId,
        this.status,
        this.relatedOrder,
        this.createdAt,
        this.locationPartialMatch,
        this.rejectionMessage,
        this.hawb,
        this.mawb,
        this.reference1Type,
        this.reference1,
        this.reference2Type,
        this.reference2,
        this.accountName,
        this.losName,
        this.warehouseCode,
        this.companyName,
      this.isOnlineSync = false});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerOrderNumber = json['customer_order_number'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    customerPhoneOne = json['customer_phone_one'];
    customerPhoneTwo = json['customer_phone_two'];
    customerEmail = json['customer_email'];
    typeOfOrder = json['type_of_order'];
    accountCode = json['account_code'];
    levelOfService = json['levelOfService'];
    whLocationId = json['wh_location_id'];
    customerAddressLine = json['customer_address_line'];
    customerAddressLine2 = json['customer_address_line_2'];
    customerAddressLine3 = json['customer_address_line_3'];
    customerCity = json['customer_city'];
    customerState = json['customer_state'];
    customerCountry = json['customer_country'];
    customerZipcode = json['customer_zipcode'];
    csLocationId = json['cs_location_id'];
    status = json['status'];
    relatedOrder = json['related_order'];
    //quotationAmount = json['quotation_amount'];
    createdAt = json['created_at'];
    locationPartialMatch = json['location_partial_match'];
    rejectionMessage = json['rejection_message'];
    hawb = json['hawb'];
    mawb = json['mawb'];
    reference1Type = json['reference_1_type'];
    reference1 = json['reference_1'];
    reference2Type = json['reference_2_type'];
    reference2 = json['reference_2'];
    accountName = json['account_name'];
    losName = json['los_name'];
    warehouseCode = json['warehouse_code'];
    companyName = json['company_name'];
    isOnlineSync = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_order_number'] = this.customerOrderNumber;
    data['customer_first_name'] = this.customerFirstName;
    data['customer_last_name'] = this.customerLastName;
    data['customer_phone_one'] = this.customerPhoneOne;
    data['customer_phone_two'] = this.customerPhoneTwo;
    data['customer_email'] = this.customerEmail;
    data['type_of_order'] = this.typeOfOrder;
    data['account_code'] = this.accountCode;
    data['levelOfService'] = this.levelOfService;
    data['wh_location_id'] = this.whLocationId;
    data['customer_address_line'] = this.customerAddressLine;
    data['customer_address_line_2'] = this.customerAddressLine2;
    data['customer_address_line_3'] = this.customerAddressLine3;
    data['customer_city'] = this.customerCity;
    data['customer_state'] = this.customerState;
    data['customer_country'] = this.customerCountry;
    data['customer_zipcode'] = this.customerZipcode;
    data['cs_location_id'] = this.csLocationId;
    data['status'] = this.status;
    data['related_order'] = this.relatedOrder;
    //data['quotation_amount'] = this.quotationAmount;
    data['created_at'] = this.createdAt;
    data['location_partial_match'] = this.locationPartialMatch;
    data['rejection_message'] = this.rejectionMessage;
    data['hawb'] = this.hawb;
    data['mawb'] = this.mawb;
    data['reference_1_type'] = this.reference1Type;
    data['reference_1'] = this.reference1;
    data['reference_2_type'] = this.reference2Type;
    data['reference_2'] = this.reference2;
    data['account_name'] = this.accountName;
    data['los_name'] = this.losName;
    data['warehouse_code'] = this.warehouseCode;
    data['company_name'] = this.companyName;
    return data;
  }
}

class CsLocation {
  String? id;
  String? name;
  String? lType;
  LAddress? lAddress;
  String? timeZoneId;
  String? timeZoneName;
  String? locationCode;
  String? status;
  String? companyName;

  CsLocation(
      {this.id,
        this.name,
        this.lType,
        this.lAddress,
        this.timeZoneId,
        this.timeZoneName,
        this.locationCode,
        this.status,
        this.companyName});

  CsLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lType = json['l_type'];
    lAddress = json['l_address'] != null
        ? new LAddress.fromJson(json['l_address'])
        : null;
    timeZoneId = json['timeZoneId'];
    timeZoneName = json['timeZoneName'];
    locationCode = json['location_code'];
    status = json['status'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['l_type'] = this.lType;
    if (this.lAddress != null) {
      data['l_address'] = this.lAddress!.toJson();
    }
    data['timeZoneId'] = this.timeZoneId;
    data['timeZoneName'] = this.timeZoneName;
    data['location_code'] = this.locationCode;
    data['status'] = this.status;
    data['company_name'] = this.companyName;
    return data;
  }
}

class LAddress {
  String? sId;
  String? addressLine1;
  String? addressLine2;
  String? zipcode;
  String? city;
  String? state;
  String? country;
  List<double>? coordinates;

  LAddress(
      {this.sId,
        this.addressLine1,
        this.addressLine2,
        this.zipcode,
        this.city,
        this.state,
        this.country,
        this.coordinates});

  LAddress.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    zipcode = json['zipcode'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['zipcode'] = this.zipcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class WhLocation {
  String? id;
  String? name;
  String? lType;
  LAddress? lAddress;
  String? timeZoneId;
  String? timeZoneName;
  String? locationCode;
  String? status;
  String? companyName;

  WhLocation(
      {this.id,
        this.name,
        this.lType,
        this.lAddress,
        this.timeZoneId,
        this.timeZoneName,
        this.locationCode,
        this.status,
        this.companyName});

  WhLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lType = json['l_type'];
    lAddress = json['l_address'] != null
        ? new LAddress.fromJson(json['l_address'])
        : null;
    timeZoneId = json['timeZoneId'];
    timeZoneName = json['timeZoneName'];
    locationCode = json['location_code'];
    status = json['status'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['l_type'] = this.lType;
    if (this.lAddress != null) {
      data['l_address'] = this.lAddress!.toJson();
    }
    data['timeZoneId'] = this.timeZoneId;
    data['timeZoneName'] = this.timeZoneName;
    data['location_code'] = this.locationCode;
    data['status'] = this.status;
    data['company_name'] = this.companyName;
    return data;
  }
}

class LAddress1 {
  String? sId;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? country;
  List<double>? coordinates;
  String? zipcode;

  LAddress1(
      {this.sId,
        this.addressLine1,
        this.addressLine2,
        this.city,
        this.state,
        this.country,
        this.coordinates,
        this.zipcode});

  LAddress1.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    coordinates = json['coordinates'].cast<double>();
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['coordinates'] = this.coordinates;
    data['zipcode'] = this.zipcode;
    return data;
  }
}
