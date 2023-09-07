

class MapsResponse {
  MapsResponse({
      this.status, 
      this.message, 
      this.balance, 
      this.object, 
      this.obj,});

  MapsResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['message'] != null) {
      message = [];
      json['message'].forEach((v) {
        message?.add(Message.fromJson(v));
      });
    }
    balance = json['balance'];
    object = json['Object'];
    obj = json['Obj'];
  }
  String? status;
  List<Message>? message;
  dynamic balance;
  dynamic object;
  dynamic obj;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (message != null) {
      map['message'] = message?.map((v) => v.toJson()).toList();
    }
    map['balance'] = balance;
    map['Object'] = object;
    map['Obj'] = obj;
    return map;
  }

}


class Message {
  Message({
      this.accessPointId, 
      this.name, 
      this.latitude, 
      this.longitude, 
      this.description, 
      this.universityID, 
      this.universityName, 
      this.cityId, 
      this.cityName, 
      this.governorateID, 
      this.governorateName, 
      this.countryID, 
      this.countryName,});

  Message.fromJson(dynamic json) {
    accessPointId = json['AccessPointId'];
    name = json['Name'];
    latitude = double.parse( json['Latitude']);
    longitude = double.parse(json['Longitude']);
    description = json['Description'];
    universityID = json['UniversityID'];
    universityName = json['UniversityName'];
    cityId = json['CityId'];
    cityName = json['CityName'];
    governorateID = json['GovernorateID'];
    governorateName = json['GovernorateName'];
    countryID = json['CountryID'];
    countryName = json['CountryName'];
  }
  int? accessPointId;
  String? name;
  double? latitude;
  double? longitude;
  dynamic description;
  dynamic universityID;
  String? universityName;
  num? cityId;
  String? cityName;
  num? governorateID;
  String? governorateName;
  num? countryID;
  String? countryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessPointId'] = accessPointId;
    map['Name'] = name;
    map['Latitude'] = latitude;
    map['Longitude'] = longitude;
    map['Description'] = description;
    map['UniversityID'] = universityID;
    map['UniversityName'] = universityName;
    map['CityId'] = cityId;
    map['CityName'] = cityName;
    map['GovernorateID'] = governorateID;
    map['GovernorateName'] = governorateName;
    map['CountryID'] = countryID;
    map['CountryName'] = countryName;
    return map;
  }

}