import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:glowshoess.id/module/homepage/controller/homepage_controller.dart';

class EditProfileController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _storage = GetStorage();
  final _connectivity = Connectivity();

  var profileImage = Rx<File?>(null);
  var profile = {
    'email': ''.obs,
    'name': ''.obs,
    'phone': ''.obs,
    'address': ''.obs,
    'photoPath': ''.obs,
  };

  final String userId = "p5ZEvPdDOWYXnwUUKc5m"; // Replace with actual user ID

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _listenToConnectivity();
  }

  // Memuat data profil dari Firestore dan GetStorage
  void loadProfile(
    TextEditingController emailController,
    TextEditingController nameController,
    TextEditingController phoneController,
    TextEditingController addressController,
  ) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        profile['email']?.value = userDoc['email'] ?? '';
        profile['name']?.value = userDoc['name'] ?? '';
        profile['phone']?.value = userDoc['phone'] ?? '';
        profile['address']?.value = userDoc['address'] ?? '';
        profile['photoPath']?.value = userDoc['photoPath'] ?? '';

        // Set nilai awal controller
        emailController.text = profile['email']?.value ?? '';
        nameController.text = profile['name']?.value ?? '';
        phoneController.text = profile['phone']?.value ?? '';
        addressController.text = profile['address']?.value ?? '';

        // Load local profile image
        if (profile['photoPath']?.value.isNotEmpty ?? false) {
          final localImage = File(profile['photoPath']?.value ?? '');
          if (await localImage.exists()) {
            profileImage.value = localImage;
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    }
  }

  // Menyimpan perubahan profil ke Firestore
  Future<void> saveProfile(
      String email, String name, String phone, String address) async {
    try {
      final data = {
        'email': email,
        'name': name,
        'phone': phone,
        'address': address,
        'photoPath': profile['photoPath']?.value,
      };

      await _firestore
          .collection('users')
          .doc(userId)
          .set(data, SetOptions(merge: true));

      Get.snackbar('Success', 'Profile updated successfully');
      _storage
          .remove('profileData'); // Hapus data lokal setelah berhasil di-upload

      // Perbarui data profil di HomePageController
      Get.find<HomePageController>().updateProfileData();
    } catch (e) {
      // Jika gagal, simpan data ke GetStorage
      _saveProfileLocally();
      Get.snackbar('Error', 'Failed to update profile, saved locally');
    }
  }

  // Menyimpan data secara lokal jika gagal upload ke Firestore
  void _saveProfileLocally() {
    final profileData = {
      'email': profile['email']?.value,
      'name': profile['name']?.value,
      'phone': profile['phone']?.value,
      'address': profile['address']?.value,
      'photoPath': profile['photoPath']?.value,
    };
    _storage.write('profileData', profileData);
    print('Profile data saved locally to GetStorage: $profileData');
  }

  // Memuat data profil dari GetStorage jika ada koneksi
  Future<void> _uploadProfileIfOnline() async {
    final storedProfile = _storage.read('profileData');
    if (storedProfile != null) {
      try {
        await _firestore
            .collection('users')
            .doc(userId)
            .set(storedProfile, SetOptions(merge: true));
        _storage.remove('profileData');
        print(
            'Profile data uploaded successfully to Firestore and removed from GetStorage.');
      } catch (e) {
        Get.snackbar('Error', 'Failed to upload profile data: $e');
      }
    }
  }

  // Memeriksa status konektivitas
  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      await _uploadProfileIfOnline(); // Coba upload profil jika online
    }
  }

  // Mendengarkan perubahan konektivitas
  void _listenToConnectivity() {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none) {
        await _uploadProfileIfOnline(); // Sinkronisasi data saat online
      }
    });
  }

  // Memilih foto profil
  void selectProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final savedImage = await File(image.path)
          .copy('${directory.path}/profile_$timestamp.jpg');

      profileImage.value = savedImage;
      profile['photoPath']?.value = savedImage.path;

      Get.snackbar('Success', 'Image saved successfully');
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  // Memuat foto profil
  void loadProfileImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync(); // Get all files in the directory
    final profileFile = files.firstWhere(
      (file) => file.path.endsWith('profile.jpg'),
      orElse: () => File(''),
    );

    if (profileFile is File && profileFile.existsSync()) {
      profileImage.value =
          profileFile; // Update the profile image if a file exists
    }
  }
}
