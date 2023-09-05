import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;

import '../model/MapsResponse.dart';

class ApiManger {

  static Future<MapsResponse>  getStation() async {
    String baseUrl = 'https://api.dmj-salek-admin.com/api/AccessPoint/GetAccessPointByCityId?cityId=306';
    Uri url = Uri.parse(baseUrl);
    http.Response response = await http.get(url);
    MapsResponse  mapsResponse = MapsResponse.fromJson(jsonDecode(response.body));
    return mapsResponse;
  }

}