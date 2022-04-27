import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodwastage/location_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key}) : super(key: key);

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  static Position? position;
  final Completer<GoogleMapController> _mapController = Completer();

  CameraPosition myCurrentLocationCameraPosition = CameraPosition(
      target: LatLng(position!.latitude, position!.longitude),
      bearing: 0.0,
      zoom: 17,
      tilt: 0.0);

  @override
  void initState() {
    super.initState();
    getMyCurrentLocation();
    print(position);
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getMyCurrentPosition().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(myCurrentLocationCameraPosition));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: myCurrentLocationCameraPosition,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      onMapCreated: (controller) {
        _mapController.complete(controller);
      },
    );
  }

  Widget buildFloatingActionButton() {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 35),
      child: FloatingActionButton(
        onPressed: () {
          goToMyCurrentLocation();
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: position != null
          ? buildMap()
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }
}
