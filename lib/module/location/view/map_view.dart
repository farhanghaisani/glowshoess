import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../controller/map_controller.dart' as local_map_controller;
import 'package:url_launcher/url_launcher.dart';

class MapView extends GetView<local_map_controller.MapController> {
  final TextEditingController _controller = TextEditingController();
  final MapController _mapController =
      MapController(); // flutter_map's MapController
  LatLng? _location;
  final List<Marker> _markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
        backgroundColor: const Color(0xFFAC9365),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Masukkan nama lokasi',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchLocation,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(-7.921550, 112.599037),
                    initialZoom: 15.0,
                    onTap: (tapPosition, latLng) {
                      _addMarker(latLng);
                    },
                    maxZoom: 18.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?apiKey=${local_map_controller.MapController.apiKey}',
                      tileProvider: NetworkTileProvider(),
                    ),
                    MarkerLayer(
                      markers: _markers,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.my_location, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (_location != null)
            Container(
              margin: const EdgeInsets.all(8.0),
              child: Text(
                'Lokasi ditemukan: ${_location!.latitude}, ${_location!.longitude}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Layanan lokasi tidak aktif.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Izin lokasi ditolak secara permanen.');
      }

      // Ambil lokasi pengguna saat ini
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      // Tambahkan marker ke peta
      _addMarker(currentLatLng);

      _mapController.move(currentLatLng, 15.0);

      // Tampilkan koordinat di UI (opsional)
      Get.snackbar(
        'Lokasi Anda',
        'Latitude: ${currentLatLng.latitude}, Longitude: ${currentLatLng.longitude}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Gagal mendapatkan lokasi: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _searchLocation() async {
    String address = _controller.text;

    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        _location = LatLng(location.latitude, location.longitude);
        _mapController.move(_location!, 15.0);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text('Lokasi tidak ditemukan.'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text('Terjadi kesalahan: $e'),
      ));
    }
  }

  void _addMarker(LatLng latLng) {
    _markers.add(Marker(
      point: latLng,
      width: 20,
      height: 20,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
              title: const Text('Marker Info'),
              content:
                  Text('Location: ${latLng.latitude}, ${latLng.longitude}'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Buka di Google Maps'),
                  onPressed: () {
                    _openGoogleMaps(latLng);
                  },
                ),
                TextButton(
                  child: const Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
        child: Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Center(
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 5, 109, 255),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _openGoogleMaps(LatLng latLng) async {
    final String googleMapsUrl =
        'https://www.google.com/maps?q=${latLng.latitude},${latLng.longitude}';
    final Uri googleMapsUri = Uri.parse(googleMapsUrl);

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(
        googleMapsUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Tidak dapat membuka Google Maps.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
