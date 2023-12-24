import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput({Key? key,required this.onSelectPlace}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  void _showPreview(double lat,double lng){
    final staticMapImageUrl = LocationHelper.generateLocationImagePreview(longitude: lng,latitude: lat);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }
  Future<void> _getCurrentUserLocation()async{
    try{
      final locData = await Location().getLocation();
      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPlace(locData.latitude,locData.longitude);
    }
    catch(error){
      return;
    }
  }
  Future<void> _selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx)=>const MapScreen(isSelecting: true,),
        fullscreenDialog: true,
    ));
    if(selectedLocation == null){
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
      widget.onSelectPlace(selectedLocation.latitude,selectedLocation.longitude);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey),
          ),
          child: _previewImageUrl == null? const Text('No Location Chosen',textAlign: TextAlign.center,):
          Image.network(_previewImageUrl!,fit: BoxFit.cover,width: double.infinity,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Select On Map'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
              ),
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
