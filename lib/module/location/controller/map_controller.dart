import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

class MapController extends GetxController {
  static const String apiKey = '877fca4d9c7e40a692e41b4b47e32a56';

  final String tileUrl =
      'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?&apiKey=$apiKey';

  final double initialLat = -6.2088;
  final double initialLon = 106.8456;

  var mapController;
}