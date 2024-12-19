import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glowshoess.id/module/camerapage/view/camerapage_view.dart';
import 'package:glowshoess.id/module/categories_page/controllers/simple_cleaning_controller.dart';

class SimpleCleaningView extends StatelessWidget {
  final controller = Get.find<SimpleCleaningController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAFBF9), // Background warna hijau muda
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: controller.onBackPressed,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Simple Cleaning",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: const DecorationImage(
                    image: AssetImage('asset/simple_cleaning_logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Jasa simple cleaning sepatu yang menyeluruh...",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              const Text("Choose Pair",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: controller.selectedPair.value,
                        items: controller.pairOptions
                            .map((pair) => DropdownMenuItem(
                                value: pair, child: Text(pair)))
                            .toList(),
                        onChanged: controller.onPairChanged,
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              const Text("Pick Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 16, color: Colors.black54),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: controller.selectedDate,
                          child: Text(
                            controller.selectedDate.value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              Text("Tambahkan Foto atau Video Sepatu",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => CameraPageView());
                  },
                  icon: Icon(Icons.camera_alt, color: Colors.white),
                  label: Text("Buka Kamera"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Subtotal",
                              style: TextStyle(color: Colors.black54)),
                          Text("Rp. ${controller.subtotal.value}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delivery fee",
                              style: TextStyle(color: Colors.black54)),
                          Text("Rp. ${controller.deliveryFee}"),
                        ],
                      ),
                      const Divider(height: 30, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            "Rp. ${controller.totalPrice.value}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.checkout,
                  icon: const Icon(Icons.attach_money, color: Colors.white),
                  label: const Text("Checkout"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
