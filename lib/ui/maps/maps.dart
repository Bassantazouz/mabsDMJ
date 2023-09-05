import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/api/api_manger.dart';
import '../../data/model/MapsResponse.dart';

class Maps extends StatefulWidget {
  static String routName = '';

  @override
  State<Maps> createState() => _MapsState();
}


class _MapsState extends State<Maps> {
  List<Marker> markers = [];

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.584280177095813,31.497689977352678),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.584280177095813,31.497689977352678),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState()  {
   init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    List<LatLng> polylinePoints = markers.map((marker) => marker.position).toList();
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: markers.toSet(),
        polylines:{Polyline(polylineId: PolylineId("12"),points: polylinePoints,color: Colors.blueAccent)},

        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

        },
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


  void createMarkers(List<Message> messages) {
    for (Message message in messages) {
      Marker marker = Marker(
        markerId: MarkerId(message.accessPointId.toString()),
        position: LatLng(message.latitude ?? 0.0, message.longitude ?? 0.0),

      );

      markers.add(marker);
    }
    log(markers.toString());
    setState(() {});
  }
 void init ()async {
   final res = await ApiManger.getStation();
   createMarkers(res.message!);
 }





}


