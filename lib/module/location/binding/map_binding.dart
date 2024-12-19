import 'package:get/get.dart';
import 'package:glowshoess.id/module/location/controller/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(),
    );
  }
}
