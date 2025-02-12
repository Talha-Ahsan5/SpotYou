import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.442,
      longitude: -122.084,
      address: '',
    ),
    this.isselecting = true,
  });

  final PlaceLocation location;
  final bool isselecting;

  @override
  State<StatefulWidget> createState() {
    return _mapsScreenState();
  }
}

class _mapsScreenState extends State<MapsScreen> {

  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isselecting ? 'Pick your location' : 'Your Location',
        ),
        actions: [
          if (widget.isselecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: widget.isselecting == false ? null : (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isselecting == true) ? {} :  {
          Marker (
            markerId: MarkerId(
              'm1',
            ),
            position: 
            _pickedLocation ??
            // _pickedLocation != null ? _pickedLocation! : alternate for this condition is just add ?? as you see above
             LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
          ),
        },
      ),
    );
  }
}
