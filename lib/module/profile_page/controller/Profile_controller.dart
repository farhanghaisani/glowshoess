import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glowshoess.id/model/profile_model.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var profile = Rx<UserProfile?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      final user = _auth.currentUser;
      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          profile.value = UserProfile.fromMap(doc.data()!);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update(updatedProfile.toMap());
        profile.value = updatedProfile; // Memperbarui data profil di controller
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }
}
