import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glowshoess.id/service/notification/NotificationService.dart';

class SimpleCleaningController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final NotificationService _notificationService = NotificationService();

  RxString selectedPair = "1 pair".obs;
  RxString selectedDate = "Pilih Tanggal".obs;
  RxInt subtotal = 0.obs;
  RxInt totalPrice = 0.obs;

  final int pricePerPair = 30000;
  final int deliveryFee = 5000;

  List<String> pairOptions = ["1 pair", "2 pair", "3 pair"];

  void onPairChanged(String? value) {
    selectedPair.value = value!;
    calculateSubtotal();
  }

  void calculateSubtotal() {
    int quantity = int.parse(selectedPair.value.split(" ")[0]);
    subtotal.value = quantity * pricePerPair;
    totalPrice.value = subtotal.value + deliveryFee;
  }

  Future<void> checkout() async {
    try {
      await firestore.collection("orders").add({
        "pair": selectedPair.value,
        "date": selectedDate.value,
        "subtotal": subtotal.value,
        "totalPrice": totalPrice.value,
        "deliveryFee": deliveryFee,
        "createdAt": FieldValue.serverTimestamp(),
      });
      Get.snackbar("Success", "Order berhasil disimpan!");
    } catch (e) {
      Get.snackbar("Error", "Gagal menyimpan order: $e");
      print("Error during checkout: $e"); // For debug purposes
    }
  }

  void onBackPressed() {
    _notificationService.showDelayedNotification();
    Get.back();
  }
}
