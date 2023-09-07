import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/api/api_manger.dart';
import '../../data/model/MapsResponse.dart';

class MapView extends StatefulWidget {
  static String routName = '';

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  List<Message> messages = [];
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  List<Polyline> polylines = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyCYsYxe7GS6bTiQPM3uFe51m_sLfji4u8I"; // Replace with your Google Maps API key

  @override
  void initState() {
    super.initState();

    init();
    // Create markers for each message

  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              30.584280177095813,31.497689977352678
            ),
            zoom: 20,
          ),
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(Message message) {
    MarkerId markerId = MarkerId(message.accessPointId.toString());
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(title: message.name),
      position: LatLng(message.latitude!, message.longitude!),
    );
    markers[markerId] = marker;
  }

  _getPolyline(Message origin, Message destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(origin.latitude!, origin.longitude!),
      PointLatLng(destination.latitude!, destination.longitude!),
      travelMode: TravelMode.driving,
    );

    List<LatLng> polylineCoordinates = [];

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      Polyline polyline = Polyline(
        polylineId: PolylineId('${origin.accessPointId}_${destination.accessPointId}'),
        color: Colors.blue,
        width: 7,
        points: polylineCoordinates,
      );

      polylines.add(polyline);
    }

    setState(() {});
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void init() async {
    final res = await ApiManger.getStation();
    for (int i = 0; i < res.message!.length!; i++) {
      messages.add(res.message![i]);
    }

    // Create markers for each message
    for (int i = 0; i < messages.length; i++) {
      _addMarker(messages[i]);
    }

    // Create polylines connecting messages
    for (int i = 0; i < messages.length - 1; i++) {
      _getPolyline(messages[i], messages[i + 1]);
    }

    // Ensure that markers and polylines are populated before calling setState
    setState(() {});
  }


}
