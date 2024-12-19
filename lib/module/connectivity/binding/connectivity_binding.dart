import 'package:get/get.dart';
import '../controller/connectivity_controller.dart'; // Sesuaikan dengan path yang benar

class ConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    // Memastikan ConnectionController disuntikkan ke seluruh aplikasi atau halaman yang memerlukannya
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true); 
  }
}
