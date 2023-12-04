/*class RefUserList {
  int? id;
  String? name;
  Address? address;
  String? phone;
  Company? company;

  RefUserList({this.id, this.name, this.address, this.phone, this.company});

  RefUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Address {
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  Address({this.suite, this.city, this.zipcode, this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String? name;
  String? bs;

  Company({this.name, this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bs'] = this.bs;
    return data;
  }
}*/
