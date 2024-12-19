import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((connectivityResults) {
      _updateConnectionStatus(connectivityResults);
    });
  }

  // Update the connection status and trigger notifications
  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    final connectivityResult = connectivityResults.first;

    // If there's no connection
    if (connectivityResult == ConnectivityResult.none && isConnected.value) {
      isConnected.value = false;
      _showNoConnectionBanner();
    } 
    // If connection is restored
    else if (connectivityResult != ConnectivityResult.none && !isConnected.value) {
      isConnected.value = true;
      _showConnectionRestoredSnackbar();
      _hideNoConnectionBanner();
    }
  }

  // Show No Internet Connection as a Banner
  void _showNoConnectionBanner() {
    Get.rawSnackbar(
      message: 'No Internet Connection',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      duration: null,  // Keep banner visible until internet is back
      messageText: Text(
        'No Internet Connection',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Show Snackbar when connection is restored
  void _showConnectionRestoredSnackbar() {
    Get.rawSnackbar(
      message: 'Internet Connected',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 8,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),  // Make this Snackbar disappear after 3 seconds
      messageText: Text(
        'You are now back online.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Hide the No Internet Connection Banner
  void _hideNoConnectionBanner() {
    Get.back();  // Close the active snackbar/banner
  }
}

