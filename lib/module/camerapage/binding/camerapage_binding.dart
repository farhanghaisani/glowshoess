import 'package:get/get.dart';
import 'package:glowshoess.id/module/camerapage/controller/camerapage_controller.dart';

class CameraPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(() => CameraPageController());
  }
}
