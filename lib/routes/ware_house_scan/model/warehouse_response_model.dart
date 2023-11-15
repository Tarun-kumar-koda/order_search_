
class WarehouseResponseModel {
  List<Locations>? locations;

  WarehouseResponseModel({this.locations});

  WarehouseResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  String? id;
  String? name;
  String? lType;
  String? phone;
  String? locationCode;
  String? email;
  String? timeZoneId;
  String? firstName;
  String? lastName;
  String? startTime;
  String? endTime;
  String? integrationCompanyId;
  String? orderCapacity;
  String? organizationId;

  Locations(
      {this.id,
        this.name,
        this.lType,
        this.phone,
        this.locationCode,
        this.email,
        this.timeZoneId,
        this.firstName,
        this.lastName,
        this.startTime,
        this.endTime,
        this.integrationCompanyId,
        this.orderCapacity,
        this.organizationId});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lType = json['l_type'];
    phone = json['phone'];
    locationCode = json['location_code'];
    email = json['email'];
    timeZoneId = json['timeZoneId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    integrationCompanyId = json['integration_company_id'];
    orderCapacity = json['order_capacity'];
    organizationId = json['organization_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['l_type'] = this.lType;
    data['phone'] = this.phone;

    data['location_code'] = this.locationCode;
    data['email'] = this.email;
    data['timeZoneId'] = this.timeZoneId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['integration_company_id'] = this.integrationCompanyId;
    data['order_capacity'] = this.orderCapacity;
    data['organization_id'] = this.organizationId;
    return data;
  }
}