import 'package:get/get.dart';
import 'package:glowshoess/module/location/controller/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
  }
}
