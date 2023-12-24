import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';
class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen({Key? key,this.initialLocation = const PlaceLocation(latitude: 37.422,longitude: -122.084),this.isSelecting = false}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectMapLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic markers = {
      Marker(markerId: const MarkerId('m1'),position: _pickedLocation ?? widget.initialLocation as dynamic),
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if(widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _pickedLocation == null ? null
              :(){
                Navigator.of(context).pop(_pickedLocation);
              },
            )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectMapLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting) ? null : markers,
      ),
    );
  }
}
