import 'package:get/get.dart';

class MapController extends GetxController {
  static const String apiKey = '877fca4d9c7e40a692e41b4b47e32a56';

  final String tileUrl =
      'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?&apiKey=$apiKey';

  // Koordinat Kota Malang
  final double initialLat = -7.9667; // Latitude Kota Malang
  final double initialLon = 112.6326; // Longitude Kota Malang

  var mapController;
}
