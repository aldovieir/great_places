import 'dart:convert';

import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBc-hbj5smxYNCXdX6-9tzzEL-cZcSI96w';

class LocationUtil {
  static String genereteLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getAdressFrom(GeoCoord position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
