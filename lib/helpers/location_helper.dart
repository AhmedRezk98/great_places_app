import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: constant_identifier_names
const GOOGLE_API_KEY = 'fkfkfkflliirrirkrf65773833883';
class LocationHelper{
  static String generateLocationImagePreview({double? latitude,double? longitude}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600*300&maptype=roadmap'
        '&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
  static Future<String> getPlaceAddress(double lat,double lng) async{
    final dynamic url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}